# GeomobileTestTask
MVVM + RxSwift was chosen as basic stack. Pretty simple binding between view models and ui elements, for table view I used RxDataSource. 
POP and DI is widly used so there will be no problem with writing tests if needed.
After successfull fetching data from web it is being saved using CoreData If something goes wrong with fetching data from web, app fetches data from local storage.

There are two structs for user entity cause core data model cause the model that used for business logic and parsing network response might change sometime, when CoreData is likly to be the same for some time - will not have to worry about it if need to change User, will just need to update its init. 

UI and navigation is dont completly by code: no storyboards, no XIBs. Layout magaed by constraints. Kingfisher pod is used to download images. 

 App does not provide visual error handling yet the design allows to add it easily with onError mechanism. Some custom errors were added for core data and network failures
