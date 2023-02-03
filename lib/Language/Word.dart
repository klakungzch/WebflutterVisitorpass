class Word{
  var notfound = {'TH':'ไม่พบข้อมูล','EN':'Not found data.'}; 

  /************************Etc**************************/
  var ok = {'TH':'ตกลง','EN':'OK'}; 
  var cancel = {'TH':'ยกเลิก','EN':'Cancel'}; 
  var date = {'TH':'วันที่','EN':'Date'}; 
  var month = {'TH':'เดือน','EN':'Month'}; 
  var year = {'TH':'ปี','EN':'Year'}; 
  var confirm = {'TH':'ยืนยัน','EN':'Confirm'}; 
  var alert = {'TH':'แจ้งเตือน!','EN':'Alert'}; 
  var close = {'TH':'ปิด','EN':'Close'}; 
  var signin = {'TH':'เข้าสู่ระบบ','EN':'Sign in'}; 
  var login = {'TH':'ล็อกอิน','EN':'Login'};
  var showall = {'TH':'แสดงทั้งหมด','EN':'Show All'}; 
  var fullname = {'TH':'ชื่อ','EN':'Full name'};
  var status = {'TH':'สถานะ','EN':'Status'};  
  var firstname = {'TH':'ชื่อ','EN':'Firstname'}; 
  var lastname = {'TH':'นามสกุล','EN':'Lastname'}; 
  var username = {'TH':'ชื่อผู้ใช้','EN':'Username'}; 
  var password = {'TH':'รหัสผ่าน','EN':'Password'}; 
  var confirmPassword = {'TH':'ยืนยันรหัสผ่าน','EN':'Confirm Password'}; 
  
  /************************Drawer**************************/
  var accountName = {'TH':'แอดมิน','EN':'ADMIN'}; 
  var menu2 = {'TH':'แดชบอร์ด','EN':'Dashboard'}; 
  var menu3 = {'TH':'จัดการบัญชีผู้ใช้การ์ด','EN':'UserGuard Management'}; 
  var menu4 = {'TH':'จัดการโปรไฟล์คอนโด','EN':'Condo Management'}; 
  var menu5 = {'TH':'ออกจากระบบ','EN':'Logout'};
  var menu6 = {'TH':'จัดการข่าว','EN':'News Management'};
  var dialogDrawerHeader = {'TH':'ยืนยันการออกจากระบบ','EN':'Confirm logout'}; 
  var dialogDrawerDetail = {'TH':'ต้องการออกจากระบบหรือไม่?','EN':'Do you want to log out?'}; 

  /************************Add Userguard**************************/
  var adduserHeader = {'TH':'จัดการบัญชีผู้ใช้การ์ด','EN':'UserGuard Management'}; 
  var addUserguard = {'TH':'เพิ่มบัญชีผู้ใช้การ์ด','EN':'Add UserGuard'}; 
  var dialogAdduserHeader1 = {'TH':'กรุณากรอกข้อมูลให้ครบทุกช่อง','EN':'Please fill out all fields.'}; 
  var dialogAdduserHeader2 = {'TH':'รหัสผ่านไม่ตรงกัน กรุณากรอกรหัสผ่านใหม่','EN':'Passwords don\'t match Please enter a new password.'}; 
  var dialogAdduserHeader3 = {'TH':'ชื่อผู้ใช้นี้มีผู้ใช้งานแล้ว โปรดใช้ชื่อผู้ใช้อื่น','EN':'This username is already in use. Please use a different username.'};

  //${word.['$lang']}
  /************************Edit Userguard**************************/
  var edituserHeader = {'TH':'แก้ไขข้อมูลบัญชีผู้ใช้ของการ์ด','EN':'Edit UserGuard'}; 
  var dialogEdituserHeader1 = {'TH':'ยืนยันการแก้ไขข้อมูลผู้ใช้','EN':'Confirm correction of user information.'}; 
  var dialogEdituserDetail1_1 = {'TH':'ต้องการแก้ไขข้อมูลผู้ใช้ของ','EN':'Do you want to correct'}; 
  var dialogEdituserDetail1_2 = {'TH':' หรือไม่?','EN':'\'s information?'};

  /************************HomePageLogin**************************/
  var dialogLoginHeader = {'TH':'ชื่อผู้ใช้งาน หรือ รหัสผ่านไม่ถูกต้อง กรุณากรอกใหม่อีกครั้ง','EN':'Incorrect username or password Please enter it again.'};

  /************************GuardManagement**************************/
  var adminHeader = {'TH':'ข้อมูลผู้ใช้ของการ์ด','EN':'User guard information'};
  var searchByfn = {'TH':'ชื่อ','EN':'Firstname'};
  var editprofile = {'TH':'แก้ไขข้อมูลของ','EN':'Edit profile'};
  var delete = {'TH':'ลบข้อมูลของ','EN':'Delete'};
  var dialogAdminHeader1 = {'TH':'ยืนยันการลบข้อมูลผู้ใช้','EN':'Confirm the deletion of user data.'};
  var dialogAdminDetail1_1 = {'TH':'ต้องการลบข้อมูลผู้ใช้','EN':'Do you want to delete'}; 
  var dialogAdminDetail1_2 = {'TH':' หรือไม่?','EN':'\'s user data?'};   

  /************************Log Dashboard**************************/
  var overview = {'TH':'ภาพรวม','EN':'Overview'}; 
  var overviewDay = {'TH':'ภาพรวมของวันที่','EN':'Overview in'};
  var overviewMonth = {'TH':'ภาพรวมของเดือน','EN':'Overview in'};
  var overviewYear = {'TH':'ภาพรวมของปี','EN':'Overview in'};
  var total1 = {'TH':'จำนวนผู้เช็คอินทั้งหมด','EN':'Total check-in amount'}; 
  var total2 = {'TH':'ยอดเช็คอินวันนี้','EN':'Today\'s check-in amount'}; 
  var total3 = {'TH':'ยอดเช็คเอาต์วันนี้','EN':'Today\'s check-out amount'};
  var chooseDate = {'TH':'เลือกวันที่ -->','EN':'Select date -->'};
  var chooseMonth = {'TH':'เลือกเดือน','EN':'Select Month'};
  var chooseYear = {'TH':'เลือกปี','EN':'Select Year'};
  var refNo = {'TH':'หมายเลขอ้างอิง','EN':'Ref No.'};
  var checkinTime = {'TH':'เวลาที่เช็คอิน','EN':'Check-in time'};  
  var checkOutTime = {'TH':'เวลาที่เช็คเอ้าท์','EN':'Check-out time'}; 
  var guardName = {'TH':'ชื่อการ์ด','EN':'Guard Name'};  
  var statusPending = {'TH':'รอดำเนินการ','EN':'Pending'}; 
  var statusSuccess = {'TH':'ชำระเงินสำเร็จ','EN':'Successful payment'}; 
  var tabbarName1 = {'TH':'บันทึกทั้งหมด','EN':'All log'};
  var tabbarName2 = {'TH':'วัน','EN':'Day'};
  var tabbarName3 = {'TH':'เดือน','EN':'Month'};
  var tabbarName4 = {'TH':'ปี','EN':'Year'};
  var times = {'TH':'ครั้ง','EN':'times'};
  var of = {'TH':'จาก','EN':'of'};
  var page = {'TH':'หน้า','EN':'Page'};

  /************************Condo Management**************************/
  var condoHeader = {'TH':'จัดการโปรไฟล์คอนโด','EN':'Condo Management'}; 
  var addCondo = {'TH':'เพิ่มคอนโด','EN':'Add Condo'}; 
  var searchBycondoName = {'TH':'ชื่อคอนโด','EN':'Condo name'};
  var condoName = {'TH':'ชื่อคอนโด','EN':'Condo name'};
  var promptpay = {'TH':'พร้อมเพย์','EN':'PromptPay'};
  var collect = {'TH':'ค่าธรรมเนียม','EN':'Collect fees'};
  var startHour = {'TH':'ชั่วโมงที่เริ่มเก็บ','EN':'Fee start hours'};
  var rate = {'TH':'เรทราคา','EN':'Rates'};
  var hour = {'TH':'ชั่วโมง','EN':'hours'};
  var perhour = {'TH':'บาท/ชั่วโมง','EN':'Baht per hour'};
  var noFee = {'TH':'ไม่มีค่าธรรมเนียม','EN':'No fee'};
  var startCollect = {'TH':'เริ่มเก็บค่าธรรมเนียมหลังจาก','EN':'Start collect fee after'};
  var editCondo= {'TH':'แก้ไขข้อมูลคอนโด','EN':'Edit profile condo'};
  var deleteCondo = {'TH':'ลบคอนโด','EN':'Delete'};
  var dialogCondoHeader1 = {'TH':'ยืนยันการลบข้อมูลคอนโด','EN':'Confirm the deletion of condo data.'};
  var dialogCondoDetail1_1 = {'TH':'ต้องการลบข้อมูลคอนโด','EN':'Do you want to delete'}; 
  var dialogCondoDetail1_2 = {'TH':' หรือไม่?','EN':'\'s condo data?'};   
  var dialogEditCondoHeader1 = {'TH':'ยืนยันการแก้ไขข้อมูลคอนโด','EN':'Confirm correction of condo information.'}; 
  var dialogEditCondoDetail1_1 = {'TH':'ต้องการแก้ไขข้อมูลคอนโด','EN':'Do you want to correct'}; 
  var dialogEditCondoDetail1_2 = {'TH':' หรือไม่?','EN':'?'};


  /************************Edit Condo**************************/
  var editCondoHeader = {'TH':'แก้ไขข้อมูลคอนโด','EN':'Edit Condo'};

  /************************Choose Condo**************************/
  var chooseCondoHeader = {'TH':'เลือกคอนโด','EN':'Choose Condo'};

  /************************News Management**************************/
  var newsHeader = {'TH':'จัดการข่าว','EN':'News Management'};
  var addNews = {'TH':'เพิ่มข่าว','EN':'Add News'};
  var searchBynewsName = {'TH':'หัวข้อข่าว','EN':'Title'};
  var newsName = {'TH':'หัวข้อข่าว','EN':'Title'};
  var newDetail = {'TH':'รายละเอียดข่าว','EN':'News Detail'};
  var newsDate = {'TH':'วันที่ลงข่าว','EN':'Datetime'};
  var dialogNewsDetail1_1 = {'TH':'ต้องการลบข้อมูลข่าว','EN':'Do you want to delete'};
  var dialogNewsDetail1_2 = {'TH':' หรือไม่?','EN':'\'s news data?'};
  var dialogEditNewsHeader1 = {'TH':'ยืนยันการแก้ไขข้อมูลข่าว','EN':'Confirm correction of news information.'};
  var dialogEditNewsDetail1_1 = {'TH':'ต้องการแก้ไขข้อมูลข่าว','EN':'Do you want to correct'};
  var dialogEditNewsDetail1_2 = {'TH':' หรือไม่?','EN':'?'};
  var choosenews = {'TH':'เลือกรูป...','EN':'Choose image...'};
  var clearimage = {'TH':'ลบรูปทั้งหมด','EN':'Clear'};
  /************************Edit News**************************/
  var editNewsHeader = {'TH':'แก้ไขข้อมูลข่าว','EN':'Edit News'};
  var editNews = {'TH':'แก้ไขข้อมูลข่าว','EN':'Edit News'};
  var deleteNews = {'TH':'ลบข่าว','EN':'Delete'};
  /************************Dialog News**************************/
  var dialogAddnewsHeader1 = {'TH':'กรุณาเพิ่มรูปไม่เกิน 3 รูป','EN':'Add 1 to 3 images.'};
  var dialogduplicatetitlenews = {'TH':'มีหัวข้อข่าวนี้อยู่แล้ว','EN':'title is already.'};
  var dialogDeleteNewsHeader1 = {'TH':'ยืนยันการลบข้อมูลข่าว','EN':'Confirm the deletion of news data.'};
  /************************Choose News**************************/
  var chooseNewsHeader = {'TH':'เลือกข่าว','EN':'Choose News'};




}