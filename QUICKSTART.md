# Quickstart Guide: Virtual Desktop on Macbook Pro M2

This guide will walk you through setting up a virtual desktop environment using Docker on your Macbook Pro M2.

## Prerequisites

Before you begin, you need to have Docker Desktop installed on your machine.

### Installing Docker Desktop on macOS

1.  **Download Docker Desktop:** Go to the official Docker website and download Docker Desktop for Mac with Apple Silicon.
    *   [Download Link](https://www.docker.com/products/docker-desktop/)
2.  **Install Docker Desktop:** Open the downloaded `.dmg` file and drag the Docker icon to your Applications folder.
3.  **Start Docker Desktop:** Launch Docker from your Applications folder. You should see the Docker icon in your menu bar.

## Step 1: Build the Docker Image

1.  **Open a Terminal:** Open the Terminal application on your Mac.
2.  **Navigate to the project directory:** Use the `cd` command to navigate to the directory where the `Dockerfile` is located.
3.  **Build the image:** Run the following command to build the Docker image. This will take a few minutes as it downloads the base image and installs the necessary software.

    ```bash
    docker build -t my-virtual-desktop .
    ```

    This command builds an image from the `Dockerfile` in the current directory and tags it with the name `my-virtual-desktop`.

## Step 2: Run the Docker Container

Once the image is built, you can run it as a container.

```bash
docker run -d -p 6080:80 --name virtual-desktop my-virtual-desktop
```

Let's break down this command:
*   `docker run`: The command to run a container.
*   `-d`: Runs the container in detached mode (in the background).
*   `-p 6080:80`: Maps port 6080 on your host machine to port 80 in the container. This is the port used to access the VNC web interface.
*   `--name virtual-desktop`: Assigns a name to your container for easy reference.
*   `my-virtual-desktop`: The name of the image you want to run.

## Step 3: Access the Virtual Desktop

1.  **Open your web browser:** Open Chrome, Safari, or Firefox.
2.  **Navigate to the VNC interface:** In the address bar, type `http://localhost:6080/` and press Enter.
3.  **Connect to the desktop:** You should see a VNC connection screen. Click the "Connect" button.
4.  **Enter the password:** When prompted for a password, use the one set in the `Dockerfile` (`password`). It is highly recommended to change this password for any production use.
5.  **You're in!** You should now see a full desktop environment in your browser. You can launch Firefox from the applications menu.

## Persisting Data

By default, any files you create inside the container will be lost when the container is removed. To persist data, you can use Docker volumes.

1.  **Create a directory on your Mac:**

    ```bash
    mkdir ~/docker-data
    ```

2.  **Run the container with a volume:** When you run the container, add the `-v` flag to mount the directory you just created into the container.

    ```bash
    docker run -d -p 6080:80 --name virtual-desktop -v ~/docker-data:/home/ubuntu/Desktop my-virtual-desktop
    ```

    This will mount the `~/docker-data` directory from your Mac to the `Desktop` directory inside the container. Any files saved to the desktop in your virtual environment will be available in the `~/docker-data` directory on your Mac, even after the container is stopped and removed.

## Stopping and Starting the Container

*   **To stop the container:**
    ```bash
    docker stop virtual-desktop
    ```
*   **To start the container again:**
    ```bash
    docker start virtual-desktop
    ```
