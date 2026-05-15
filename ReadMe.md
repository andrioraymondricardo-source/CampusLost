# CampusLost

CampusLost is an iOS lost-and-found app for university students. Users can select a university, create lost/found reports, pin exact item locations on a map, filter reports, and resolve their own reports.

## GitHub Repository

https://github.com/andrioraymondricardo-source/CampusLost

## Frameworks Used

- SwiftUI
- MapKit
- UserDefaults
- Codable
- Foundation

## Main Features

- University selection
- Lost/found report creation
- Category, status, and report type filtering
- Exact map location pinning
- Map annotations for reports
- Local report ownership using device user ID
- Resolve report feature

## Instructions

When the app is first ran, there will be no data in this app since no report has yet been stored in the UserDefaults. Recommended app running manual:
- Select the add tab and add reports to the app storage data. (Singular/multiple reports can be added depending on the user. However, it's the more the better.)
    - While adding the reports, the user must select a pinned location for each reports. This location represents the estimate location on where the item(s) is lost or found.
    - Depending on what is selected as the location in the form, the user will be directed to a certain region while setting location as default. The user may notice that the initial region shown will change if the data filled in the location field is changed.
- After all the reports are added, the user can switch back to home tab and filter and search through the added reports.
- Not only this, the user can also switch to the map tab and see all added reports on the map with their precise location. The user can also filter reports on this page.
- If the user does not see any items in the map tab even after adding reports, the user is recommneded to switch map regions either through Location buttons on the top of the screen or by manually sliding throughout the map.
    - Note: The items only visible in the user's screen will appear in the "Items in this area" panel. If any report is out of the view of the user's screen, this item will NOT appear in the list.

