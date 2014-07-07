
TeenahApp
================

TESTING CODE:


4. Hiding the keyboard in first/second hand shake issue.
5. After logining in for the first time it does not show uploading image.
6. Exception when closing the application.
9. Logless.
10. Fullname is null whenever started.
13. When showing the contacts, no search bar appears in the first time update.
15. Consider saying no rows.
16. After adding a relationship with number it shows nothing.
18. Do not forget to add a job for calculating the ages.
19. View event: the creator has a not updated information.
20. Consider back button after adding a new event.
22. Creator image is enlarging when appearing again -- also reloading the image twise.
25. The image should not be reloaded again and agian whenever the cell appears.
26. Update the likes count whenever the member likes a member, event, media.
27. Notify the user whenever the member has been added, in member relations context.
28. Liking a comment has some issues, when liking another comment after liking one comment.
29. Has some issue when logining in.

FIXES:

DONE: AddMemberEducationViewController
DONE: AddMemberJobViewController
DONE: ViewMemberTableViewController -- Except the age matter.
DONE: AddEventViewController
DONE: SecondHandShakeLoginTableViewController
DONE: FirstHandShakeLoginTableViewController

1. Checking the indian numbers if they understood as numbers not encoded strings.
2. When clicking ok done on complete registeration.
3. KeyChain integer issues.
7. https://api.teenah-app.com/v1/events says "Not authorized to use this resource." when empty events.
11. Update the user information is not moving it correctly. // Done, because of multi-threading issue.
21. After saying will come or apologizing for an event, the cell should be updated.
12. Adding an education of BSc, nil Major, Start: 2006, ongoing does not get back. This one worked in desktop but not in mobile.
17. I guess we could enforce adding a major for the person.
24. When updating the information of a member if the server responded with 400 is different of responsing 403.
8. Design a better design for images for medias.
29. When sending a login SMS, notify the user to wait, or about the current situation.
30. Make sure to accept the indian numbers.

TODO:

15. Circle is not being created for first time when visiting the circles view for second time.
16. Run command for calculating member ages every day.
27. Fix the thumb and photos (avatars).
30. Shorten the fullname or display name.
39. SSL.
44. Forms validation.
45. Fixing the liking of comments after each other.

DONE:

33. Validate chat messages before sending.
43. Mobile numbers they should be correct.
32. Taste, taste, and more taste.
42. Loading events whenever the user has a new one.
41. Issue when sending a text message in the circles, need to know what is happining.
35. Add members to a specific circle.
36. Add circles.
25. Make every non-selection cell clear color.
22. Remove adding father/mother whenever there is already one.
31. Get the members whome invited to an event.
13. Handle errors when calling API.
20. Fix multi-language issue.
8. Hide keyboard, or show it appropriatly.
40. Don't draw the labels and buttons and objects generally twice (context: multi-columns cell).

FUTURE:

6. Make a correct relation when a member adds a brother or a sister.
3. Keep local data as cached data rather than calling up the server each time.
2. Make sure that the internet connection is on.
4. Make sure that the app does not run when driving.
12. Implement searching in CircleMembersTableViewController.
17. Publish the libraries related to TeenahApp project with the latest version (use Pods).
24. Done with the updating educations.
37. Trustees, make sure that the appropriate members modify the appropriate members.
38. Privacies.
39. Location directions.
14. Consider emoj. the input was empty.
28. MBProgressHUD consider changing the appearance of it.
29. Give the user to choose the appropriate view for events.
30. The end time of an event should be optional.
31. When entering a city name the coordinates should be near.

