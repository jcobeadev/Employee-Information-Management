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
 

What I did first here is to learn about coordinators.

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
