# AWS Ops Plugin

The `aws-ops-plugin` offers a seamless and efficient way to manage your AWS profiles right from the terminal. At its core, this tool operates by manipulating environment variables, ensuring that the correct AWS configurations are always in use. While it's possible to achieve similar behavior by manually setting and adjusting these variables in the terminal, the process can be cumbersome and prone to errors. Additionally, the `aws-ops-plugin` incorporates a validation step, checking if a specified profile exists before setting the environment variable. This added layer of verification ensures that you don't accidentally set an incorrect or non-existent profile, further enhancing the reliability and convenience of the tool. The plugin, was designed for reduce the necessity of write extensive code or remember intricate commands. Whether you're a developer juggling multiple AWS accounts or an administrator overseeing various AWS configurations, this plugin streamlines your workflow, allowing you to set, list, and manage your AWS profiles and SSO sessions with ease.

## Prerequisites

- **Operating System**: This plugin is designed for Unix-like operating systems, such as Linux and macOS.

- **AWS CLI v2 or Higher**: This plugin requires the AWS Command Line Interface version 2 or later. You can verify your current version with `aws --version` and update if necessary, [check official documentation](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

- **SSO Configuration**: Before using this plugin, you must have AWS SSO set up with related access profiles. To configure SSO, use the `aws configure sso` command. Your `~/.aws/config` file should have entries resembling the following structure:

  ```bash
  [sso-session SampleSession]
  sso_start_url = https://sample-url.example.com/
  sso_region = us-east-1
  sso_registration_scopes = sso:account:access
  [profile SampleProfile]
  credential_source = 'sso-session SampleSession'
  sso_session = SampleSession
  sso_account_id = 123456789012
  sso_role_name = SampleRole
  region = us-east-1
  output = json
  [profile AnotherProfile]
  source_profile = SampleProfile
  role_arn = arn:aws:iam::123456789012:role/SampleRoleAccess
  region =  us-east-1
  output = json
  ```

## Installation

1. Clone this repository:

```bash
git clone https://github.com/biagolini/aws-ops-plugin  ~/.aws-ops-plugin
```

2. Grant execution permissions to the installation script:

For Ubuntu:

```bash
chmod +x ~/.aws-ops-plugin/install_ubuntu.sh
```

For macOS:

```bash
chmod +x ~/.aws-ops-plugin/install_mac.sh
```

3. Run the installation script:

For Ubuntu:

```bash
~/.aws-ops-plugin/install_ubuntu.sh
```

For macOS:

```bash
~/.aws-ops-plugin/install_mac.sh
```

Follow the prompts to choose where you'd like to source the plugin from (e.g., ~/.bashrc or ~/.zshrc).

4. Important: Restart your terminal for the changes to take effect or manually run

```bash
source /usr/bin/ops-aws-profile
```

## Usage

### Listing saved AWS profiles and SSO sessions

To list all saved AWS profiles:

```bash
ops profiles
```

To list all SSO sessions:

```bash
ops sessions
```

### Setting an AWS Profile

Use the ops command followed by the profile name:

```bash
ops <PROFILE_NAME>
```

For instance, if you have a profile named "AnotherProfile", you would use:

```bash
ops AnotherProfile
```

Once a profile is set, all subsequent AWS commands will use that profile until a new one is set or the terminal session is closed. If the specified profile does not exist in your configuration, an error message will be displayed.

### SSO Login

You can login using your AWS SSO configuration, by:

```bash
ops login <SSO_SESSION_NAME>
```

For instance, if you have a sso-session named "SampleSession", you would use:

```bash
ops login SampleSession
```

### Configuring AWS Config File

To switch the AWS configuration file dynamically:

```bash
ops config <CONFIG_FILE_NAME>
```

For example, to use a specific configuration file named “config2”, execute:

```bash
ops config config2
```


### Unsetting the Current AWS Profile

If you wish to revert to the default AWS profile or simply remove the currently set profile, you can use the following command:

```bash
ops unset
```

Upon executing this command, the AWS_PROFILE environment variable will be unset, and subsequent AWS commands will not use any specific profile unless another one is set using the ops command. This can be particularly useful when you want to ensure that no profile is being used accidentally, or if you want to switch back to using the default AWS credentials.

## Contributing

Feel free to submit issues, create pull requests, or fork the repository to help improve the project.

## License and Disclaimer

This project is open-source and available under the MIT License. You are free to copy, modify, and use the project as you wish. However, any responsibility for the use of the code is solely yours. Please use it at your own risk and discretion.
