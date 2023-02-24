List<String> d1 = [""];
List<String> d4 = ["", "", "", ""];
List<List<String>> d42 = [
  ["", "", "", ""]
];
String a = "A", b = "B", c = "C", d = "D";
List<String> az = ["A"], bz = ["B"], cz = ["C"], dz = ["D"];

// --- - - -- - - -- - -
List<int> qID = [for (int i = 101; i <= 200; i++) i]; // S

List<List<String>> listQuestion = [
  for (int i = 0; i < 31; i++) d1,
  for (int i = 0; i < 69; i += 3)
    [question[i], question[i + 1], question[i + 2]]
];

List<List<List<String>>> listAnswers = [
  for (int i = 0; i < 31; i++) d42,
  for (int i = 0; i < 69; i += 3) [answers[i], answers[i + 1], answers[i + 2]]
];

List<List<String>> listRightAnswer = [
  for (int i = 0; i < 31; i++) [rightAns[i]],
  for (int i = 31; i < 100; i += 3)
    [rightAns[i], rightAns[i + 1], rightAns[i + 2]]
];
List<int> partID = [
  for (int i = 1; i <= 6; i++) 1,
  for (int i = 7; i <= 31; i++) 2,
  for (int i = 32; i <= 70; i += 3) 3,
  for (int i = 71; i <= 100; i += 3) 4,
];

List<String> audio = [
  for (int i = 1; i <= 54; i++)
    "https://studenthcmusedu-my.sharepoint.com/:u:/g/personal/20120470_student_hcmus_edu_vn/EQFNWfKBSptIiXfx196k_5wBt5J8utYqJkj_H7ixSF8F_A?e=byCxA2"
];
List<List<String>> imagesURL = [
  //part 1
  [
    "https://studenthcmusedu-my.sharepoint.com/personal/20120470_student_hcmus_edu_vn/Documents/TOEIC-APP-DATA/Exam_1/1.jpg",
    "https://studenthcmusedu-my.sharepoint.com/personal/20120470_student_hcmus_edu_vn/Documents/TOEIC-APP-DATA/Exam_1/2.jpg",
    "https://studenthcmusedu-my.sharepoint.com/personal/20120470_student_hcmus_edu_vn/Documents/TOEIC-APP-DATA/Exam_1/3.jpg",
    "https://studenthcmusedu-my.sharepoint.com/personal/20120470_student_hcmus_edu_vn/Documents/TOEIC-APP-DATA/Exam_1/4.jpg",
    "https://studenthcmusedu-my.sharepoint.com/personal/20120470_student_hcmus_edu_vn/Documents/TOEIC-APP-DATA/Exam_1/5.jpg",
    "https://studenthcmusedu-my.sharepoint.com/personal/20120470_student_hcmus_edu_vn/Documents/TOEIC-APP-DATA/Exam_1/6.jpg"
  ],

  [
    for (int i = 0; i < 10; i++) "",
    "https://studenthcmusedu-my.sharepoint.com/personal/20120470_student_hcmus_edu_vn/Documents/TOEIC-APP-DATA/Exam_1/62.jpg",
    "https://studenthcmusedu-my.sharepoint.com/personal/20120470_student_hcmus_edu_vn/Documents/TOEIC-APP-DATA/Exam_1/65.jpg",
    "https://studenthcmusedu-my.sharepoint.com/personal/20120470_student_hcmus_edu_vn/Documents/TOEIC-APP-DATA/Exam_1/68.jpg",
    for (int i = 0; i < 8; i++) "",
    "https://studenthcmusedu-my.sharepoint.com/personal/20120470_student_hcmus_edu_vn/Documents/TOEIC-APP-DATA/Exam_1/95.jpg",
    "https://studenthcmusedu-my.sharepoint.com/personal/20120470_student_hcmus_edu_vn/Documents/TOEIC-APP-DATA/Exam_1/98.jpg",
  ]
];

int examID = 1;

bool isPremium = false;

List<String> rightAns = [
  b,
  a,
  c,
  d,
  b,
  c,
  c,
  c,
  b,
  c,
  b,
  a,
  c,
  b,
  c,
  a,
  b,
  a,
  c,
  b,
  b,
  c,
  a,
  b,
  a,
  b,
  b,
  b,
  c,
  a,
  a,
  b,
  d,
  b,
  c,
  a,
  d,
  b,
  d,
  d,
  a,
  d,
  c,
  c,
  d,
  c,
  c,
  a,
  d,
  c,
  d,
  d,
  a,
  c,
  d,
  b,
  c,
  a,
  b,
  a,
  d,
  d,
  c,
  d,
  b,
  b,
  c,
  a,
  d,
  c,
  b,
  c,
  a,
  c,
  d,
  a,
  c,
  a,
  b,
  c,
  d,
  a,
  b,
  d,
  c,
  b,
  a,
  d,
  c,
  a,
  b,
  a,
  c,
  d,
  b,
  b,
  a,
  d,
  a,
  c
];

List<String> question = [
  "What is the conversation about?",
  "What does the woman say will happen on Friday?",
  "What will the woman do next?",
  "Why does the man thank the woman?",
  "According to the man, what has changed today?",
  "What does the man say he will do next?",
  "What is the man planning for his staff?",
  "What is the man concerned about?",
  "What will Helen provide to the man?",
  "What type of business do the speakers work for?",
  "Why does the woman say, 'buying a commercial truck is expensive'?",
  "What does the man recommend doing?",
  "Where is the conversation taking place?",
  "What is scheduled to happen on September 1?",
  "What will the man do next?",
  "Where is the conversation taking place? ",
  "What has the man been assigned to do? ",
  "What does the woman suggest when she says, “I'm covering the reception desk”?",
  "Why did the man visit the woman's busines?",
  "According to the woman,what has her assistant done?",
  "What does the man say he will do in a half hour?",
  "What is the man working on today? ",
  "According to the man, what has caused some problems? ",
  "What does the woman offer to do? ",
  "What is theconversation mainly about? ",
  "Why is a change being introduced?",
  "What does the woman ask employees to do this week?",
  "What industry do the speakers most likely work in?",
  "What is the man concerned about doing?",
  "What does the woman say she will do?",
  "What kind of event are the speakers discussing?",
  "Look at the graphic. Which room do the speakers plan to use?",
  "Why will the woman call Emmerich Hall?",
  "What most likely is the man's job?",
  "Look at the graphic. Which line needs to be changed?",
  "What does the woman plan to do tomorrow?",
  "Why is the woman planning an event?",
  "Why is the woman planning an event?",
  "What is the woman asked to do by Friday?",
  "What kind of product is being advertised?",
  "What benefit of the product does the speaker mention?",
  "How can listeners get a free gift?",
  "Where most likely are the listeners?",
  "What are some of the listeners advised to do?",
  "What will the speaker do soon?",
  "Who is Lewis Gibbons?",
  "What will Lewis Gibbons discuss on the show?",
  "What are listeners encouraged to send to the speaker?",
  "Where does the speaker most likely work?",
  "What does the speaker suggest when she says, 'we have five events on Saturday'? ",
  "What does the speaker mention about a parking lot?",
  "Who most likely are the listeners?",
  "What does the speaker imply when he says, 'we've sold the two hundred tickets'? ",
  "What does the speaker mention about Paul Johnson?",
  "Where are the listeners?",
  "According to the speaker, what task has been recently added?",
  "Why should the listeners contact Douglas?",
  "What feature of the lake does the speaker find impressive?",
  "According to the speaker, what have officials been focusing on?",
  "Why does the speaker want to pause the hike now?",
  "What is the topic of the speaker's talk?",
  "What does the speaker recommend?",
  "What does the speaker most likely mean when she says, 'The evening shift workers will arrive shortly'?",
  "Why is the speaker looking for a new landscaping firm?",
  "Look at the graphic.Which plan does the speaker want to use? ",
  "What is the listener asked to do? ",
  "Who most likely are the listeners?",
  "Look at the graphic. Which room will be used for storage?",
  "According to the speaker,what will the listeners do at ten o'clock?",
];
List<List<String>> answers = [
  [
    "A product launch",
    "A group interview",
    " A retirement party",
    " A business trip"
  ],
  [
    "Some supplies will be ordered.",
    "New regulations will go into effect.",
    "An inspection will be held.",
    "A renovation project will take place."
  ],
  [
    "Set up a meeting room",
    "Request a schedule change",
    "Sign up for an event",
    "Review an e-mail message"
  ],
  [
    " She made a recommendation.",
    "She finished a report on time.",
    "She covered a coworker's shift.",
    "She helped a customer."
  ],
  ["A closing time", "A sale price", "An hourly wage", "A local supplier"],
  [
    "Attend a festival",
    "Hire more workers",
    "Print a schedule",
    "Post a notice"
  ],
  [
    "A fitness activity",
    "An art class ",
    "A film screening",
    "A museum visit "
  ],
  [
    "The time constraints ",
    "The travel distance ",
    "The overall cost ",
    "The difficulty level "
  ],
  [
    "A Web site link ",
    "A business card",
    "Some product brochures",
    "Some sample images"
  ],
  [
    "A print shop ",
    "A moving company",
    "An advertising firm",
    "A travel agency"
  ],
  [
    "To express appreciation for an offer",
    "To explain the reason for a loan",
    "To propose giving the man a ride",
    "To show disapproval for an idea"
  ],
  [
    "Adjusting a price list",
    "Conducting a survey",
    "Using a local service",
    "Providing extra training"
  ],
  [
    "Adjusting a price list",
    "Conducting a survey",
    "Using a local service",
    "Providing extra training"
  ],
  [
    "At an electronics store",
    "At an art museum ",
    "At a movie theater ",
    "At a television studio"
  ],
  [
    "Ticket prices will increase. ",
    "Some advertisements will be run. ",
    " A business will be relocated. ",
    "A director will give a talk. "
  ],
  [
    "Prepare a work schedule ",
    "Update a Web site ",
    "Look for some equipment",
    "Write a review "
  ],
  ["At a grocery mart", "At a hotel", "At a dental clinic ", "At a law firm "],
  [
    "Add information to a database ",
    "Install some security equipment ",
    "Set up an Internet connection ",
    "Welcome customers as they arrive "
  ],
  [
    "The man has made a mistake. ",
    "The man should not worry about a task. ",
    "She will sign for a package.",
    "She cannot assist the man. "
  ],
  [
    "To give a demonstration",
    "To set up a banner ",
    "To make a delivery ",
    "To repair a device "
  ],
  [
    "He has printed a form.",
    "He has left work early. ",
    "He has prepared a payment. ",
    " He has cleared an area. "
  ],
  [
    "Speak to a manager ",
    "Give the woman a document ",
    "Present a parking pass ",
    "Ask for a signature "
  ],
  [
    "Gathering customer opinions ",
    "Planning a delivery route ",
    "Interviewing job candidates ",
    "Preparing a sales presentation "
  ],
  [
    "Some documents are lost.",
    "The budget is not big enough.",
    "Some supplies are out of stock.",
    "An employee is absent from work"
  ],
  [
    "Make a reservation",
    "Proofread a document",
    "Order a new machine",
    "Visit a store in person"
  ],
  [
    "A decrease in the hours of operation",
    "A new way of checking loan eligibility",
    "A revised procedure for compensating employees",
    "A different style of team meetings"
  ],
  [
    "To attract staff members",
    "To follow a regulation",
    "To save time",
    "To cut expenses"
  ],
  [
    "Test a computer program",
    "Attend a training session",
    "Update their personnel files",
    "Contact their immediate supervisor"
  ],
  [
    "Fashion design",
    "Internet security",
    "Magazine publishing",
    "Energy production"
  ],
  [
    "Explaining the details of a process",
    "Meeting with a client in person",
    "Finishing a task by a deadline",
    "Handling a customer's complaint"
  ],
  [
    "Upgrade a device",
    "Apologize to a client",
    "Send the man some information",
    "Assign a task to a coworker"
  ],
  [
    "A product demonstration",
    "A career fair",
    "An awards ceremony",
    " A fashion show"
  ],
  ["Cobalt", "Azure", "Indigo", "Sapphire"],
  [
    "To request a discount",
    "To check a schedule ",
    "To book a tour",
    "To pay a deposit"
  ],
  ["Professional musician", "Graphic designer", "Theater owner", "Event host"],
  ["Line 1", "Line 2", "Line 3", "Line 4"],
  [
    "To encourage teamwork among employees",
    "To thank employees for their hard work",
    "To improve the fitness level of employees",
    "To attract a new type of client"
  ],
  ["3 hours", "2.5 hours", "2 hours", "1.5 hours"],
  [
    "Arrange transportation",
    "Find pricing information",
    "Get a head count",
    " Submit a form"
  ],
  [
    "A phone speaker",
    "A portable charger",
    "A personal laptop ",
    "A rechargeable flashlight "
  ],
  [
    "It comes with a guarantee. ",
    " It is made from recycled materials",
    "It works with a variety of devices. ",
    "It is water-proofed. "
  ],
  [
    "By providing a discount code",
    "By recommending a product ",
    "By completing a survey ",
    "By ordering more than one item "
  ],
  [
    "At a department store ",
    "At a concert hall",
    "At a bus terminal ",
    "At an airport "
  ],
  [
    "Monitor their belongings",
    "Download a schedule ",
    "Go to another building ",
    "Exchange a ticket "
  ],
  [
    "Provide more information ",
    "Introduce a colleague ",
    "Issue discount vouchers ",
    "Address customer complaints "
  ],
  ["An author", "A film director ", "A photographer ", "A govemment official "],
  [
    " Industry trends ",
    "Cutting-edge equipment ",
    "Volunteer opportunities ",
    " Environmental policies "
  ],
  [
    "Brief videos ",
    "Topic suggestions ",
    "Contest entries ",
    "Origial pictures "
  ],
  [
    "At a conference hall",
    "At a financial institution",
    " At a catering company",
    " At a convenience store"
  ],
  [
    "She is pleased with the popularity of a service. ",
    " She will hire some temporary workers.",
    "An online schedule contains an error.",
    "The business cannot accommodate a request."
  ],
  [
    "It is currently unavailable.",
    "It is reserved only for employees.",
    "It increased fees.",
    "It introduced new meters."
  ],
  [
    "Insurance salespeople",
    "Newspaper journalists",
    "Healthcare professionals",
    "Corporate investors"
  ],
  [
    "He forgot to update some information.",
    "A session will be moved to a larger room.",
    "The price of some tickets will go up.",
    "An event was in high demand."
  ],
  [
    "He may arrive late. ",
    "He founded a company.",
    "He won an award.",
    "He will sign books."
  ],
  [
    "At an office complex",
    "At a garden center",
    "At a hardware store",
    "At a sports venue"
  ],
  [
    "Setting up a seating area",
    "Leading group tours",
    "Recruiting new customers",
    "Updating a Web site"
  ],
  [
    "To report equipment problems",
    "To request a list of lectures",
    "To suggest a new event",
    " To get an admission pass"
  ],
  [
    "Its temperature",
    "Its size",
    "Its variety of wildlife",
    " Its number of trails"
  ],
  [
    "Reducing pollution levels",
    "Making activities for children",
    "Improving map accuracy",
    "Building a visitor center"
  ],
  [
    "To decide on a route",
    " To have some beverages",
    "To respond to questions",
    " To take some pictures"
  ],
  [
    "New safety measures",
    "Customer feedback comments",
    "Factory job openings",
    "Increased production goals"
  ],
  [
    "Changing the length of shifts",
    "Holding more managers' meetings",
    "Conducting training by video",
    "Expanding a delivery area"
  ],
  [
    "The listeners should take a break.",
    "A problem has been resolved.",
    "She would like the listeners to be patient.",
    "She needs to wrap up a meeting."
  ],
  [
    "The current company is under new ownership. ",
    "The current company has an unreliable service.",
    "Funding for the service has been decreased. ",
    "A contract could not be renewed."
  ],
  ["Standard", "Standard Plus", "Growth", "Premium"],
  [
    "Approve an expense",
    "Visit a business",
    "Collect more data",
    "Give a presentation"
  ],
  ["Book editors", " Interior designers", "Computer programmers", "Architects"],
  ["301", "302", "303", "304"],
  [
    "Review some company policies",
    "Take a building tour",
    "Get their identification",
    "Be assigned to teams"
  ],
];
