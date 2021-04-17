# pi-bootstrap
A repository that shows how to use Pi-Gen and Github Secrets+Actions to create a ready-to-use Raspberry Pi image that includes connectivity to your home Wi-Fi, custom packages and build steps without forking pi-gen or having to build an image on your machine.

## Github-only Usage

1. Click ![image-20210416222151898](media/image-20210416222151898.png)and create a new public/private repository in your account based on this template.

   :warning: *If you plan to use this repository to create a ready-to-use image that includes your Wi-Fi SSID, passphrase or other private information, it is recommended to create a private repository at this stage*

2. Navigate to ![image-20210416225541954](media/image-20210416225541954.png)and then ![image-20210416225617502](media/image-20210416225617502.png) (in the sidebar)

3. Add secrets and values for the following supported arguments if required. If you're a developer creating more templates for other users, you can skip this step to use defaults or make sure to delete any artifacts that may contain sensitive information. Your secrets will not be propagated to any repositories created using your template

| Name                | Description                                                  |
| ------------------- | ------------------------------------------------------------ |
| **IMAGE_NAME**      | This is the name of the generated image. Defaults to the name of the repository |
| **FIRST_USER**      | The username of the first user on the generated image. Defaults to *pi* |
| **FIRST_USER_PASS** | The password for the first user on the generate image. Defaults to *raspberry* |
| **HOSTNAME**        | The name with which your newly booted pi will identify itself to any networks. Defaults to *IMAGE_NAME* |
| **SSH_ENABLED**     | 1 to enable SSH, 0 to disable SSH. Defaults to *1*           |
| **WPA_COUNTRY**     | Two-character ISO-3166-1 alpha-2 country code for your country. *Not setting this will keep Wi-Fi disabled via rfkill* |
| **WPA_SSID**        | SSID of your Wi-Fi network, if you want to enable Wi-Fi connectivity. *Not setting this will keep Wi-Fi disabled via rfkill* |
| **WPA_PASSPHRASE**  | Passphrase of your Wi-Fi network, if you want to enable Wi-Fi connectivity. *Not setting this will keep Wi-Fi disabled via rfkill* |

4. Navigate to the ![image-20210416231117301](media/image-20210416231117301.png) tab and then edit [bootstrap/00-packages](bootstrap/00-packages) to add or remove any packages your custom image might need

5. Optionally, you can edit [config](config), [bootstrap/01-run.sh](bootstrap/01-run.sh) and/or [bootstrap/02-run.sh](bootstrap/02-run.sh) to add, remove or re-order custom installation steps and commit your changes
   :bulb: See [.github/workflows/manual.yml](.github/workflows/manual.yml) for an example of how to add custom secrets that are then propagated via [pi-gen/build-docker.sh](pi-gen/build-docker.sh) to any custom build steps you create

6. Finally, to build an image for testing, navigate to ![image-20210416232008223](media/image-20210416232008223.png)and select the ![image-20210416232050305](media/image-20210416232050305.png)workflow. You can then pick the branch want to build
   ![image-20210416232231819](media/image-20210416232231819.png)

7. Click ![image-20210416232332897](media/image-20210416232332897.png) and wait for the workflow run to finish. This may take 30+ minutes, depending on the packages and custom installation steps you've selected

8. Once the workflow completes successfully, you will be able to download the image it built for you

   :warning: Free Github accounts only come with 2000 minutes of Actions usage per month, so be careful of your usage minutes.

9. Burn your custom image onto a microSD card using [Imager](https://www.raspberrypi.org/software/), or [Etcher](https://www.balena.io/etcher/)

10. Pop the microSD card in, power up your raspberry pi and wait for it to boot. Test your custom image and repeat steps 4-9 as needed

11. Once you're happy with your custom image, you can create a release in order to lock that configuration for deployment. Go to the ![image-20210416231117301](media/image-20210416231117301.png)tab and click ![image-20210416233657764](media/image-20210416233657764.png)on the right. Enter all release details and hit ![image-20210416233817873](media/image-20210416233817873.png)

12. Wait for the workflow to finish and you should see your new release appear in the ![image-20210416234024343](media/image-20210416234024343.png) section along with your newly-minted image (and the source code packages)

13. Burn your custom image onto a microSD card using [Imager](https://www.raspberrypi.org/software/) or [Etcher](https://www.balena.io/etcher/) and start using it in your Raspberry pi!

