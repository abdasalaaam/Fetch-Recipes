# Steps to Run the App

Clone this repository into your local directory by running this command in the terminal:
git clone https://github.com/abdasalaaam/Fetch_Recipes.git

Navigate to the cloned directory and open the Fetch-Recipes.xcodeproj file in Xcode. After that, select your simulator or physical device in Xcode and click the run button. 

# Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas? 

I focused on the following areas:
- Data and error handling: I recognized that one of the important constraints of the project was to handle the different error cases elegantly, so I ensured that I incorporated a reliable and cohesive solution to extend and reference the different types of errors that can occur. 
- User Interface: I focused on creating a UI that was simple yet effective while making use of all the data provided. I displayed the recipes in a List, showing their small image, name, and cuisine, and allowed them to be clicked to display a popup of their larger image and links to their recipe or video. 
- Code Structure: I used the MVVM pattern, enhancing code structure and scalability. I made effort to ensure that each part and piece had its own dedicated functionality with high code cohesiveness 
- Testing: Implemented unit tests that cover the critical functionalities and created a non-obstructive testing popup which appears by long-pressing the "Recipes" title, allowing the user to functional test as an admin

# Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent about 5 hours working on this project. 
- 1.5 hours designing and developing the server utility RecipeFetcher and the RecipesViewModel to cover all error cases robustly with extensibility and reusability. 
- 2 hours total working on the views and data and state management. I had some debugging to do and change of heart with some of the UI approaches. 
- .5 hours creating the unit tests and mock RecipeFetcher objects
- 1 hour debugging, finetuning, and optimizing the code and unit tests, and covering edge cases such as:
    - some small photo URLs were returning 404 errors, I substituted with the large URL in those cases
    - ensuring when you retry it retries with same previous URL
    - network or unrelated errors

I made use of ChatGPT to create the unit tests and to integrate the image caching.

# Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I had the following decision points:
- The application needed an easy way to load from the three test URLs rather than building and replacing its code. So I incorporated a menu that you can select which URL you want to load from. My initial thought was a settings button, but I thought this was more of an admin feature, so integrated it as a result of long pressing the "Recipes" title. I also went against allowing to load from custom input URLs in this screen, as the scope does not currently require that
- Using inline recipe details with expanding list cells rather than a modal that pops up upon recipe click, but after thinking about it from a user perspective, I believe having the dedicated space to a single recipe creates more focus on that recipe. It also allows for scrollability and incorporating the actual recipe in-app in the modal popup in the future. 

# Weakest Part of the Project: What do you think is the weakest part of your project?

There are a few weak points:
- I think the application can be more aesthetically pleasing. The UI elements are relatively bare and can use some flavor and custom styling along with icons
- Unit tests can cover more code
- Strings are hard coded for current simplicity of the application but should be stored in a strings file

# External Code and Dependencies: Did you use any external code, libraries, or dependencies?

Yes, I used Kingfisher for the image caching which allowed me to focus more on core functionality without reinventing existing technology. 

# Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

Just as a note, the admin feature of long-pressing the Recipes title is intended to only function in dev environments, and would be toggled off in released code

Additional features:
- Long press the recipe title to change the data you're loading
- Tap the recipe row to get a popup and view its recipe and video

Ways to extend it in the future:
- Incorporate recipes in-app
- Make it look nicer
- Get gift card rewards for using recipes from certified vendors (wink wink)

Have fun and I hope you like it!
