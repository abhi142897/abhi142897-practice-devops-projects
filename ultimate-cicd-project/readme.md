AWS Continuous Integration project

Set Up GitHub Repository:
The first step is to set up a GitHub repository to store our Python application's source code.

Configure AWS CodeBuild:
In this step, we'll configure AWS CodeBuild to build our Python application based on the specifications we define. CodeBuild will take care of building and packaging our application for deployment. Follow these steps ->
Log in to the AWS Console.
Open CodeBuild and create a new project.
Provide a project name and description, and select GitHub as the source.
Connect to GitHub using OAuth and create a secret with a custom name when prompted.
Create a role or select an existing one (you can attach policies to the role afterwards).
Write a Buildspec file in YAML format.
Use the Parameter Store from Systems Manager to store your Docker username, password, and URL. Reference these variables in the env section of the Buildspec file.
Create the CodeBuild project.
When you run the build, it may fail because the role does not have permissions for Systems Manager and Docker. Attach the necessary policies for these permissions. Additionally, edit the build to provide privileged access for Docker push.

Create an AWS CodePipeline:
In this step, we'll create an AWS CodePipeline to automate the continuous integration process for our Python application. AWS CodePipeline will orchestrate the flow of changes from our GitHub repository to the deployment of our application. Follow these steps ->
Log in to the AWS Console, open CodePipeline, and click on "Create Pipeline."
Create a new role as prompted and click "Next."
Select GitHub v2 as the source provider, connect to GitHub, provide the repository name, and specify the main branch name.
In the trigger configuration, do not select any filters.
Click "Next" and select CodeBuild as the build provider, using the project created in the previous step, then click "Next."
Do not select a deployment provider and click "Next."
Click "Create Pipeline."
The build will start automatically. Now, if you change anything in your GitHub repository and push, the pipeline will trigger a new build automatically.

Trigger the CI Process:
In this final step, we'll trigger the CI process by making a change to our GitHub repository. Let's see how it works ->
Go to your GitHub repository and make a change to your Python application's source code. It could be a bug fix, a new feature, or any other change you want to introduce.
Commit and push your changes to the branch configured in your AWS CodePipeline.
Head over to the AWS CodePipeline console and navigate to your pipeline.
You should see the pipeline automatically kick off as soon as it detects the changes in your repository.
Sit back and relax while AWS CodePipeline takes care of the rest. It will fetch the latest code, trigger the build process with AWS CodeBuild, and deploy the application if you configured the deployment stage.


CodeDeploy Steps
Go to CodeDeploy and create an application.
Create an EC2 instance and install the CodeDeploy agent on it. You can follow the installation guide here -> 
https://docs.aws.amazon.com/codedeploy/latest/userguide/codedeploy-agent-operations-install-ubuntu.html
Create a role to grant the EC2 instance permission to communicate with CodeDeploy. Assign the CodeDeploy full access policy to this role.
Attach the role to the EC2 instance and restart the CodeDeploy agent service on the instance.
Similarly, create a role for CodeDeploy with full EC2 instance access.
In CodeDeploy, create a deployment group and attach the previously created role. Ensure to provide the Git repository and the latest commit ID. The appspec.yml and the scripts folder referenced in appspec.yml should be present at the root level of the repository.

Final Steps
Go to CodePipeline, click on Edit, then Add Stage, and add a CodeDeploy stage. Select AWS CodeDeploy as the provider, and enter the application name and deployment group name created earlier.

Flow Overview
When a push occurs in GitHub, the source stage in CodePipeline will pull the latest code. CodeBuild will then be triggered with this latest code. After a successful build, the Docker image will be pushed to Docker Hub, and the deployment stage will be triggered, using the pushed Docker image to deploy it on the server.