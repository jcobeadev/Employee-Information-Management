# Employee Information Management
 A project that shows the list of employees of particular company. A company can also edit the information of the employee. This application uses MVVM for UI Presentation and Coordinators to handle navigation of the entire application. It also uses RxSwift for binding data. The data are retrieved and persisted in a json file.

#
**Dear Reviewers,**

Thank you for taking the time to review my project

So in this project, I followed MVVM-C for the user interface architecture, Coordinator to handle the navigation of the application, and RXSwift for binding data. Initially, I was planning to create a separate scheme for business logic for this project to become platform agnostic, and run the test in macOS target so I can run the test fast (TDD approach). But, since I didn’t have experience in RXSwift and Coordinator, and with the time constraint I decided to learn Coordinator and RxSwift first by creating the entire application itself.

**How I implemented the task**

* I watched some tutorials regarding with the coordinator pattern.
* I implemented the _coordinator_ in parallel of creating the user interface at storyboard (Login, EmployeeList)
* Since I need the fetch and persist some _JSON_ file that in the device. I made some research and it brings me to saving the file at the _Documents_ directory.  
* I created a separate model that will _interact_ when where persisting and when where displaying it to the UI. I created *PersistableCompany* to represent the _low level_ data and *Company* to represent _high level_ data. If you browse the file, you will see that the property casing (camelCase, snake_case) of both file is different. I used snake_case in the low level data for us to easily interact with JSON file. I used camelCase in the high level data because it is the coding standard and swift. High Level Data should be also a light weight data, and it shouldn't have dependency.
* I created extensions of an array to easily convert High level and Low Level Data.
* In relation with the functionalities of the application. I created a separated protocol for it. I used protocol here to respect *Dependency Inversion* of the _SOLID_ principles. This will be located at _Service_ folder (SignUpLocalDataManager, LoginLocalDataManager, EmployeeLocalDataManager, etc.). These functionalities made like this for us to easily inject other infrastructure (like if we want to save it in Realm or CoreData).
* I also created a file called _CompanyProvider_, that will Provide if the has session and who's that company. 
* As of the moment, all functionalities are implemented by *LocalDataManager* and this class is injected in the viewModels where is it needed.
* Since I can now successfully read and write data in the JSON file, I decided to learn data bindings in RXSwift. RxSwift is broad topic so I just decided to use the basics of it. 
* I implemented validation using RXSwift.
* In relation with the framework dependency, at first I decided to use _Cocoapod_ but since I don't want the reviewer to put time in installing the pod. I decided to switch in _Swift Package Manager_.
* I implemented error handling and presentation of the alert. I created custom enums for this one, because this will help us to handle error easily. You can check *DataManagerError*, *SignupError*.
* I used the last minute of the time to create some test. But for some reason, I cannot test the application. It is because the application is looking for 'RxCocoaRuntime'. I currently searching the cause of this. (_Im going to try to solve this at *unit-testing-and-ci* branch_)

#
**Things that I think needed to be improved/implemented**
* *Implement Unit Testing* (requirement of the task)
* Saving and object by one, not replacing the json file.
* Procotols/Properties naming
* Usage of RxSwift
* Implement Dependency Diagram
 

## Application Data Flow Diagram
<p align="center">
<img src="https://github.com/jcobeadev/Employee-Information-Management/blob/main/Files/AppDataFlowCoordinator.png" alt="App Data Flow Diagram" title="App Data Flow Diagram"/>
</p>

## Demo
<p align="center">
<img src="https://github.com/jcobeadev/Employee-Information-Management/blob/main/Files/Signup.gif" alt="Signup" title="Signup"/ width=230>
<img src="https://github.com/jcobeadev/Employee-Information-Management/blob/main/Files/Login.gif" alt="Login" title="Login"/ width=230>
<img src="https://github.com/jcobeadev/Employee-Information-Management/blob/main/Files/AddEmployee.gif" alt="AddEmployee" title="AddEmployee"/ width=230>
<img src="https://github.com/jcobeadev/Employee-Information-Management/blob/main/Files/EditEmployee.gif" alt="EditEmployee" title="EditEmployee"/ width=230>
<img src="https://github.com/jcobeadev/Employee-Information-Management/blob/main/Files/Logout.gif" alt="Logout" title="Logout"/ width=230>
<img src="https://github.com/jcobeadev/Employee-Information-Management/blob/main/Files/LoginOtherCompany.gif" alt="LoginOtherCompany" title="LoginOtherCompany"/ width=230>
</p>
