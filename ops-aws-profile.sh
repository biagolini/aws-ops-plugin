# Function to set the AWS profile, list profiles/SSO sessions, or unset the AWS profile
set_aws_profile() {
    term1="$1"
    term2="$2"

    # Check if the user wants to list AWS profiles
    if [ "$term1" = "profiles" ]; then
        # Use grep and sed to extract profile names from the AWS config file.
        grep '\[profile' ~/.aws/config | sed 's/\[profile //' | sed 's/\]//'
        return
    fi

    # Check if the user wants to list SSO sessions
    if [ "$term1" = "sessions" ]; then
        # Use grep and sed to extract SSO session names from the AWS config file.
        grep '\[sso-session' ~/.aws/config | sed 's/\[sso-session //' | sed 's/\]//'
        return
    fi

    # Check for the sso-login action
    if [[ "$term1" = "login" && -n "$term2" ]]; then
        # Check if the SSO session or profile exists in the AWS config file
        if ! grep -q "\[sso-session $term2\]" ~/.aws/config && ! grep -q "\[profile $term2\]" ~/.aws/config; then
            echo "Error: The name '$term2' is not recognized as a valid profile or SSO session."
            echo "To view available profiles, use: ops profiles"
            echo "To view available SSO sessions, use: ops sessions"
            return
        fi
        aws sso login --sso-session "$term2"
        return
    fi

    # Check if the user wants to unset the AWS profile
    if [ "$term1" = "unset" ]; then
        unset AWS_PROFILE
        echo "AWS Profile unset successfully."
        return
    fi

    # Change the default AWS config file
    if [ "$term1" = "config" ] && [ -n "$term2" ]; then
        config_path="$HOME/.aws/$term2"
        if [ -f "$config_path" ]; then
            export AWS_CONFIG_FILE="$config_path"
            echo "AWS Config file changed to: $AWS_CONFIG_FILE"
        else
            echo "Error: Configuration file '$term2' not found in ~/.aws/"
        fi
        return
    fi
    
    # Check if the profile exists in the AWS config file
    if ! grep -q "\[profile $term1\]" ~/.aws/config; then
        echo "Error: Profile '$term1' not found!"
        return
    fi

    # Default action is to set the AWS profile
    export AWS_PROFILE="$term1"
    echo "AWS Profile set to: $AWS_PROFILE"
}
alias ops=set_aws_profile

# Intercepting function for the 'aws' command
aws_with_profile() {
    if [ -n "$AWS_PROFILE" ]; then
        command aws "$@" --profile "$AWS_PROFILE"
    else
        command aws "$@"
    fi
}
alias aws=aws_with_profile

