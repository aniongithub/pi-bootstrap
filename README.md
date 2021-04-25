# pi-bootstrap
A repository that shows how to use Pi-Gen and Github Actions to create a ready-to-use Raspberry Pi image that includes connectivity to your home Wi-Fi, custom packages and build steps without opening a terminal or any manual setup. You can do all of this directly within the Github UI, which significantly lowers the barrier of entry for novice users, who don't need to understand a lot of the technical details.

Youtube video explaining the what, why and how.

[![Bootstrapping the Raspberry Pi using GitHub Actions](http://img.youtube.com/vi/Lc6wvHgMYH4/0.jpg)](http://www.youtube.com/watch?v=Lc6wvHgMYH4 "Bootstrapping the Raspberry Pi using GitHub Actions ")

:gear: This repository is intended as a basic template for developers who wish to create ready-to-use bootstrap repositories meant for novice users. See [aniongithub/raspotify-appliance](https://github.com/aniongithub/raspotify-appliance) for an example of a repository meant for novice end-users to use directly

## Github Actions Usage

1. Click ![image-20210416222151898](media/image-20210416222151898.png)and create a new public/private repository in your account based on this template.

   :warning: *If you plan to use this repository to create a ready-to-use image that includes your Wi-Fi SSID, passphrase or other private information, it is recommended to create a private repository at this stage*

2. Navigate to ![image-20210416225541954](media/image-20210416225541954.png)and then ![image-20210416225617502](media/image-20210416225617502.png) (in the sidebar)

3. Add secrets and values for the following supported arguments as required. Note that if you skip adding a secret (think of secrets as an override to the default value), the default value for that argument will be used instead.

   :gear: *If you're a developer creating templates for other users, you can skip this step to use safe defaults you can test with*

| Name                | Description                                                  |
| ------------------- | ------------------------------------------------------------ |
| **IMAGE_NAME**      | This is the name of the generated image. Defaults to the name of the repository you created in step 1 |
| **FIRST_USER**      | The username of the first user on the generated image. Defaults to *pi* |
| **FIRST_USER_PASS** | The password for the first user on the generated image. Defaults to *raspberry* |
| **HOSTNAME**        | The name with which your newly booted pi will identify itself to any networks. Defaults to *IMAGE_NAME* |
| **SSH_ENABLED**     | 1 to enable SSH, 0 to disable SSH. Defaults to *1*           |
| **WPA_COUNTRY**     | [Two-character ISO-3166-1 alpha-2 country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) for your country. *Not setting this will keep Wi-Fi disabled via rfkill* |
| **WPA_SSID**        | SSID of your Wi-Fi network, if you want to enable Wi-Fi connectivity. *Not setting this will keep Wi-Fi disabled via rfkill* |
| **WPA_PASSPHRASE**  | Passphrase of your Wi-Fi network, if you want to enable Wi-Fi connectivity. *Not setting this will keep Wi-Fi disabled via rfkill* |

4. Navigate to the ![image-20210416231117301](media/image-20210416231117301.png) tab and then edit [bootstrap/00-packages](bootstrap/00-packages) to add or remove any packages your custom image might need

5. Optionally, you can edit [config](config), [bootstrap/01-run.sh](bootstrap/01-run.sh) and/or [bootstrap/02-run.sh](bootstrap/02-run.sh) to add, remove or re-order custom installation steps and commit your changes
   :gear: See [raspotify-appliance](https://github.com/aniongithub/raspotify-appliance/blob/4630f5e29d3b1fb35e4e65169327b97377b4f06a/.github/workflows/release.yml#L54) for an example of how to add custom secrets (`DEVICE_NAME`) that are then propagated to [config](config) via [pi-gen/build-docker.sh](pi-gen/build-docker.sh) to any custom build steps you create

6. If you want to build an image for testing, navigate to ![image-20210416232008223](media/image-20210416232008223.png)and select the ![image-20210424193432121](/home/ani/Projects/pi-bootstrap/media/image-20210424193432121.png) workflow. You can then pick the branch want to build the test image with:
   ![image-20210416232231819](media/image-20210416232231819.png)

   *:gear: You can also use the `Manual` workflow for a fully parameterized run without using secrets. However, be aware that any private information will show up in logs for that run.*
   
7. Click ![image-20210416232332897](media/image-20210416232332897.png) and wait for the workflow run to finish. This may take 30+ minutes, depending on the packages and custom installation steps you've selected

   :warning: Free Github accounts only come with 2000 minutes of (Linux) Actions usage per month, so be careful with your usage minutes!

8. Once the workflow completes successfully, you will be able to download the image it built for you

   :warning: Make sure to delete or hide any artifacts that may contain sensitive information. Your secrets will not be propagated to any repositories created using your template, but artifacts and logs may be visible to anyone who can see the repository

9. Burn the image from step 8 onto a micro-SD card using [Imager](https://www.raspberrypi.org/software/), [Etcher](https://www.balena.io/etcher/) or another program of you choice

10. Insert the micro-SD card into your pi, power it up and wait for it to boot. Repeat steps 4-10 as needed

11. Once you're happy with your custom image, you can create a release to lock in that configuration for posterity. Go to the ![image-20210416231117301](media/image-20210416231117301.png)tab and click ![image-20210416233657764](media/image-20210416233657764.png)on the right. Enter your release details and hit ![image-20210416233817873](media/image-20210416233817873.png)

12. Wait for the `Release` workflow to finish and you should see your new release appear in the ![image-20210416234024343](media/image-20210416234024343.png) section along with your newly-minted image (and the source code packages it was built from)

13. Burn your custom image onto a microSD card using [Imager](https://www.raspberrypi.org/software/) or [Etcher](https://www.balena.io/etcher/) and start using it in your Raspberry pi!

