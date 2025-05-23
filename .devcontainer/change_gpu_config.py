import json
import re

try:
    devcontainer_txt = ""
    with open(".devcontainer/devcontainer.json") as read_file:
        devcontainer_txt = read_file.read()
except:
    "❌ Failed to read '.devcontainer/devcontainer.json' file."

try:
    # Devcontainer.json files can contain comments, which are technically not allowed in JSON.
    devcontainer_txt = re.sub(r'//.*', '', devcontainer_txt)
    devcontainer_txt = re.sub(
        r'/\*.*?\*/', '', devcontainer_txt, flags=re.DOTALL)
    devcontainer_json: dict = json.loads(devcontainer_txt)
except:
    "❌ Failed to parse '.devcontainer/devcontainer.json' file."


# ===================================================================


# Helper function to prompt the user for a choice
def get_choice(question: str, choices: list[str], mapping: list):
    """
    Prompts the question and lists the possible answers.\\
    The first answer will always be selected as the default answer.\\
    Returns the relative mapped content.
    """
    if len(choices) != len(mapping):
        raise ValueError("Choices and mapping must have the same length.")
    print("\n" + question)
    for i, choice in enumerate(choices):
        print(f"{i + 1}. {choice}", "(default)" if i == 0 else "")
    try:
        choice = input("Number: ").strip()
        choice = 1 if choice == "" else int(choice[0])
    except:
        pass

    while choice not in range(1, len(choices) + 1):
        print("\nInvalid choice. Please try again.")
        try:
            choice = input("Number: ").strip()
            choice = 1 if choice == "" else int(choice[0])
        except:
            pass

    choice_idx = choice - 1
    result = mapping[choice_idx]
    return result


# ===================================================================


gpu = get_choice(question="Pick an option:",
                 choices=["I have a GPU and my project requires it.",
                          "I don't have a GPU or my project does not require it."],
                 mapping=[True, False])


if gpu:
    # Add GPU-related arguments in "runArgs"
    run_args: list[str] = devcontainer_json.get("runArgs", list([]))
    run_args: list[str] = [arg for arg in run_args if arg not in (
        "--gpus=all", "--runtime=nvidia")]
    run_args.extend(
        ["--gpus=all", "--runtime=nvidia"])
    devcontainer_json["runArgs"] = run_args

    # Set "gpu" requirement to True in "hostRequirements"
    host_requirements: dict = devcontainer_json.get("hostRequirements", {})
    host_requirements["gpu"] = True
    devcontainer_json["hostRequirements"] = host_requirements
    devcontainer_json["postCreateCommand"] = "bash .devcontainer/scripts/post_create.sh gpu"


if not gpu:
    # Remove GPU-related arguments in "runArgs" if they exist
    run_args: list[str] = devcontainer_json.get("runArgs", [])
    devcontainer_json["runArgs"] = [
        arg for arg in run_args if arg not in ("--gpus=all", "--runtime=nvidia")]

    # Set "gpu" requirement to False in "hostRequirements" if it exists
    host_requirements: dict = devcontainer_json.get("hostRequirements", {})
    if "gpu" in host_requirements:
        host_requirements["gpu"] = False
    devcontainer_json["hostRequirements"] = host_requirements
    devcontainer_json["postCreateCommand"] = "bash .devcontainer/scripts/post_create.sh cpu"

# ===================================================================


try:
    with open(".devcontainer/devcontainer.json", "w") as f:
        json.dump(devcontainer_json, f, indent=2)
except:
    "❌ Failed to update '.devcontainer/devcontainer.json' file."

print("\n✅ Updated '.devcontainer/devcontainer.json' file.\n")
