# push-notifications-firebase-API-V1--SwiftUI

SwiftUI implementation of Push Notifications with Firebase (Google Cloud Messaging) API V1 without Server

All apps currently utilizing the Legacy FCM APIs must transition to the new FCM V1 APIs for sending push notifications by June 20, 2024, to ensure uninterrupted service.

Brands must generate a service account from their Firebase console and update it in the Conversational Cloud UI.
This update is specific to iOS aside from uploading the JSON to the brand’s app, no other code changes are required to begin using the new FCM V1.

This page covers the steps to:
1. Create a “Service Account” in the Firebase Console
2. Provide the Service Account information in the Conversational Cloud UI
3. In order to download the service account from the Firebase Console, you would need to follow these steps:
4. Login to the Firebase console for the project and open Settings > Service Accounts
5. Click on the Generate New Private Key button to download the JSON. Store this json securely since it will be used in the next few steps

<img width="1468" alt="GenerateServiceAccountJson" src="https://github.com/user-attachments/assets/c43cdcd1-0074-41ac-8c87-cbd84834fd88">

Start Xcode, add the GoogleService-Info.plist file to the project, and launch the app.
Go to the Import tab and click the plus button in the top right corner to import the downloaded JSON file.

![Simulator Screenshot - iPhone 15 - 2024-10-11 at 17 47 04](https://github.com/user-attachments/assets/9dcb65a5-5aa2-41a1-ad35-4e9c927c87e3)

## Usage 

- Register Topic.
- Add the Title and Body, along with any additional extra data rows.
- Then Click on Send Push

![Simulator Screenshot - iPhone 15 - 2024-10-11 at 17 29 35](https://github.com/user-attachments/assets/cc094f14-235d-49fa-b316-0fa924a42c9b)


## Contribute 

Contributions are warmly welcomed! Feel free to reference the todos above or file an issue.


## Contact

[Skype] live:pethanihiten_1

## Liscense

MIT
