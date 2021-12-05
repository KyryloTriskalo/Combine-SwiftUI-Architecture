# Best architecture for SwiftUI + Combine

# The content of the presentation:
1. First of the proposed architectures - MVP + C
2. Second of the proposed architectures - MVVM + C
3. Descriptions of principles of the Service Locator pattern
4. Service Locator pattern implementation using Resolver 
5. Third of the proposed architectures - MVVM and pattern Service Locator
6. Comparative table of architectures
7. Conclusions
8. Resources 

# Presentation links:
https://github.com/KyryloTriskalo/Combine-SwiftUI-Architecture/blob/main/Telegram/Telegram/Resources/MVVM%2BCombine%2BSwiftUI.pdf - read verison
https://chiswdevelopment.sharepoint.com/sites/iOSteam/Shared%20Documents/Forms/AllItems.aspx?id=%2Fsites%2FiOSteam%2FShared%20Documents%2FGeneral%2FRecordings%2FДоклад%20на%20тему%20%5FЛучшая%20архитектура%20для%20связки%20combine%20%2BSwiftUI%5F%2D20210916%5F160159%2DЗапись%20собрания%2Emp4&parent=%2Fsites%2FiOSteam%2FShared%20Documents%2FGeneral%2FRecordings video conference

# Resources
**First architecture:**

https://lascorbe.com/posts/2020-04-27-MVPCoordinators-SwiftUI-part1/ - 1 part\
https://lascorbe.com/posts/2020-04-28-MVPCoordinators-SwiftUI-part2/ - 2 part\
https://lascorbe.com/posts/2020-04-29-MVPCoordinators-SwiftUI-part3/ - 3 part

**Second architecture:**

MVVM + C + Swift architecture (wrappers for SwiftUI modules)\
https://github.com/Lascorbe/SwiftUI-MVP-Coordinator - git\
https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3 - tutorial

**Resolver:** 

https://github.com/hmlongco/Resolver - git
https://www.raywenderlich.com/22203552-resolver-for-ios-dependency-injection-getting-started - tutorial\

**Fake REST API:**

https://github.com/typicode/json-server - git\
https://www.youtube.com/watch?v=7vx0RIwHVzg&t=928s - tutorial

# How launch local server:
 1) https://nodejs.org/uk/download/ - download node js for your mac
 2) in terminal run ' npm install -g json-server ' 
 3) in terminal run ' json-server --watch db.json '
 4) copy data from database.json (lay inside the Network Manager folder) and paste it on the db.json file
 5) cmd + s, quit terminal, and repeat step 3 in place where you created db.json file

