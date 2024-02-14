# sauce-upload
For remote device testing on Browserstack. This step allows you to upload an APK file to BrowserStack and use the returned app_url for testing on real devices

# How to use this Step
Can be run directly with the bitrise CLI, just git clone this repository, cd into it's folder in your Terminal/Command Line and call bitrise run test.

Check the bitrise.yml file for required inputs which have to be added to your .bitrise.secrets.yml file!

# Step by step:

Open up your Terminal / Command Line
git clone the repository
cd into the directory of the step (the one you just git cloned)
Create a .bitrise.secrets.yml file in the same directory of bitrise.yml (the .bitrise.secrets.yml is a git ignored file, you can store your secrets in it)
Check the bitrise.yml file for any secret you should set in .bitrise.secrets.yml
Best practice is to mark these options with something like # define these in your .bitrise.secrets.yml, in the app:envs section.
Once you have all the required secret parameters in your .bitrise.secrets.yml you can just run this step with the bitrise CLI: bitrise run test
An example .bitrise.secrets.yml file:

envs:
- A_SECRET_PARAM_ONE: the value for secret one
- A_SECRET_PARAM_TWO: the value for secret two

# How to create your own step
Create a new git repository for your step (don't fork the step template, create a new repository)
Copy the step template files into your repository
Fill the step.sh with your functionality
Wire out your inputs to step.yml (inputs section)
Fill out the other parts of the step.yml too
Provide test values for the inputs in the bitrise.yml
Run your step with bitrise run test - if it works, you're ready
For Step development guidelines & best practices check this documentation: https://github.com/bitrise-io/bitrise/blob/master/_docs/step-development-guideline.md.

NOTE:

If you want to use your step in your project's bitrise.yml:

git push the step into it's repository
reference it in your bitrise.yml with the git::PUBLIC-GIT-CLONE-URL@BRANCH step reference style:
- git::https://github.com/user/my-step.git@branch:
   title: My step
   inputs:
   - my_input_1: "my value 1"
   - my_input_2: "my value 2"
You can find more examples of step reference styles in the bitrise CLI repository.

# How to contribute to this Step
Fork this repository
git clone it
Create a branch you'll work on
To use/test the step just follow the How to use this Step section
Do the changes you want to
Run/test the step before sending your contribution
You can also test the step in your bitrise project, either on your Mac or on bitrise.io
You just have to replace the step ID in your project's bitrise.yml with either a relative path, or with a git URL format
(relative) path format: instead of - original-step-id: use - path::./relative/path/of/script/on/your/Mac:
direct git URL format: instead of - original-step-id: use - git::https://github.com/user/step.git@branch:
You can find more example of alternative step referencing at: https://github.com/bitrise-io/bitrise/blob/master/_examples/tutorials/steps-and-workflows/bitrise.yml
Once you're done just commit your changes & create a Pull Request
# Share your own Step
You can share your Step or step version with the bitrise CLI. If you use the bitrise.yml included in this repository, all you have to do is:

In your Terminal / Command Line cd into this directory (where the bitrise.yml of the step is located)
Run: bitrise run test to test the step
Run: bitrise run audit-this-step to audit the step.yml
Check the share-this-step workflow in the bitrise.yml, and fill out the envs if you haven't done so already (don't forget to bump the version number if this is an update of your step!)
Then run: bitrise run share-this-step to share the step (version) you specified in the envs
Send the Pull Request, as described in the logs of bitrise run share-this-step
That's all ;)
