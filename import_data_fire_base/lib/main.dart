import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:import_data_fire_base/model.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await createHistory();

  // await createUser();

  // await createDoctor();

  // await createHospital();



  runApp(const MyApp());
}


Future createHistory() async {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  HospitalHistory hospital = HospitalHistory(
      id: "BOpAo4S2aDmulHzq2ApQ",
      address: "75 Nguyễn Huệ, P Phú Hội, TP. Huế",
      hospitalName: "Phòng khám đa khoa Thiện Hòa",
      image: "https://dam.northwell.edu/m/2c1dbf361ac2d767/Drupal-web_Huntington_9191335-3_edit-sky_clouds.jpg",
      phone: "0234 3922 298"
  );

  DoctorHistory doctor = DoctorHistory(
      id: "UZTzODtldy9QJOVariom",
      fullName: "Đào Xuân Hòa",
      image: "https://honghunghospital.com.vn/wp-content/uploads/2020/08/6.-L%C3%AA-Nguy%C3%AAn-Kha-scaled.jpg"
  );

  UserHistory user = UserHistory(
      id: "88zfUPPgwLxGq9mRchRD",
      email: "nguyenbichphuong@gmail.com",
      image: "https://meliawedding.com.vn/wp-content/uploads/2022/03/hinh-anh-nguoi-mau-lam-hinh-nen-dien-thoai-26-552x1024.jpg",
      phone: "0961654991"
  );

  List<DetailService> details = [
    DetailService(serviceName: "Phí dịch vụ", price: "180,000đ"),
    DetailService(serviceName: "Nhổ răng", price: "120,000đ")
  ];

  TotalCost totalCost = TotalCost(
      total: "300,000đ",
      details: details
  );



  await fireStore.collection("histories").add(


    History(
        id: "id",
        hospital: hospital,
        doctor: doctor,
        appointment: "10:00 A.M 12/04/2022",
        userId: user.id,
        user: user,
        shareHistory: true,
        symptom: "Đau răng, đau tự phát hoặc đau xảy ra mà không có nguyên nhân rõ ràng. Răng nhạy cảm. Đau nhẹ đến đau khi ăn hoặc uống thứ gì đó ngọt, nóng hoặc lạnh.",
        note: "Nên nghỉ ngơi ít nhất trong 24 giờ đầu tiên sau khi nhổ răng. Tránh súc miệng. Không sử dụng ống hút",
        diagnosis: "Đau răng",
        totalCost: totalCost
    ).toJson()

  ).then((value) {
    print("ID ------> ${value.id}");
  });

}


Future createUser() async{

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  await fireStore.collection("users").add(
    User(
        id: fireStore.collection("users").id,
        fullName: "Lê Văn Quang",
        email: "levanquang@gmail.com",
        phone: '0961987568',
        gender: true,
        dob: '21/02/2001',
        image: 'https://toanthaydinh.com/wp-content/uploads/2020/04/hpz1442034296-7.jpg'
    ).toJson()
  ).then((value) => print("SUCCESS ${value.id}"));

}

Future createHospital() async {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  String id = "";

  await fireStore.collection("hospitals").add(
      Hospital(
          id: 'id',
          hospitalName: "Phòng khám đa khoa Quốc Tế Hạnh Phúc",
          image: "https://www.nhsfife.org/media/1017/sb_victoriahospitalcuts_270416-7jpg-e1473857945618.jpg?anchor=center&mode=crop&width=1200&height=600&rnd=132865653060000000",
          fee: "170,000đ",
          address: "15 Nguyễn Tri Phương, P Vỹ Dạ, TP. Huế",
          phone: "0234 3922 666",
          star: 4,
          services: ['Khám Răng','Xét Nghiệm Máu','Khám Tai'],
          workingHours: "Thứ 7 - CN || 07:30 A.M - 17:30 P.M",
          information: "Bệnh viện là cấu phần quan trọng của hệ thống cung cấp dịch vụ y tế. Để đạt được bao phủ chăm sóc sức khỏe toàn dân (UHC), việc xác định rõ vai trò và tối ưu hóa hiệu suất của bệnh viện là không thể thiếu. Tuy nhiên, nhiều quốc gia vẫn đang phải đối mặt với những khó khăn trong việc lên kế hoạch và  quản lý bệnh viện. Những thách thức ở cấp độ bệnh viện,  như quản lý yếu kém, thời gian chờ đợi lâu, chất lượng dịch vụ và độ an toàn thấp, và sự chưa hài lòng của bệnh nhân hiện đang ảnh hưởng đến hoạt động  của bệnh viện. Ở cấp độ của hệ thống y tế, các thách thức như  chưa phối hợp đầy đủ với hệ thống chăm sóc sức khỏe ban đầu, chi phí leo thang, quy định  lỏng lẻo và giám sát không chặt chẽ cũng làm suy giảm các đóng góp của hệ thống bệnh viện cho sức khỏe  người dân.",
          certifications: ['Chứng nhận ISO 9001','Chứng nhận cấp cứu','Chứng nhận bệnh viện bền vững '],
          wards: [
            {
            "wards_name" : "Khoa Mắt",
            "doctors" : ["Phạm Ngọc Đức","Nguyễn Quang Tú"]
            }
          ]
      ).toJson()
  ).then((value) {
    print("SUCCESS ${value.id}");
    id = value.id;
  });


  var reviews = [
    {
      'star' : 4,
      'review_day' : '20/04/2020',
      'content' : 'Chất lượng khám bệnh tốt, thái độ phục vụ của nhân viên tốt.',
      'user' : {
        'id': 'kO14fgHIBfpROrzp9ewh',
        'full_name': "Trương Công Anh",
        'image': "https://we25.vn/media2018/Img_News/2019/01/22/6_20190122163634.jpg"
      },
    },
    {
      'star' : 4,
      'review_day' : '20/08/2018',
      'content' : 'Chất lượng khám bệnh tốt, thái độ phục vụ của nhân viên tốt, phòng khám sạch sẽ.',
      'user' : {
        'id': 'uMUgzLY4ySDekqYnmOQN',
        'full_name': 		"Phan Hữu Hiếu",
        'image': 	"https://vnn-imgs-f.vgcloud.vn/2021/04/14/09/nhiep-anh-gia-8x-theo-duoi-ve-dep-nguoi-phu-nu-qua-tung-khung-hinh.jpg"
      },
    }
  ];

  var doctors = [
    {
      "id" : "MrdCVWNfyGE6sR9va8BO",
      "full_name" : "Phạm Ngọc Đức",
      "image" : 	"https://nguonluc.com.vn/uploads/images/blog/huyenvan/2022/02/27/nlntv-bac-si-tre-nhan-hoc-bong-harvard-hinh-anh-benh-nhan-ngheo-luon-trong-tam-tri-1645961235.jpeg",
      "fields" : "Chuyên Khoa Mắt"
    },
    {
      "id" : "asH2sn0OdWGBZCyGZsWd",
      "full_name" : "Nguyễn Quang Tú",
      "image" : "https://kenh14cdn.com/2019/8/13/324c44b6bc9c4a369e3c328ace33e94c-1565680805737753985702.jpeg",
      "fields" : "Chuyên Khoa Mắt"
    }
  ];

  for(int i = 0 ; i < 2 ; i++) {
    await fireStore.collection("hospitals").doc(id).collection("reviews").add(
        reviews[i]
    );

    await fireStore.collection("hospitals").doc(id).collection("doctors").add(
        doctors[i]
    );

  }





}


Future createDoctor() async {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  String id = "";

  await fireStore.collection("doctors").add(
      Doctor(
          id: fireStore.collection("users").id,
          fullName: "Lễ Viết Vũ",
          image: "https://www.fvhospital.com/wp-content/uploads/2018/11/Dr-Truong-Hieu-Nghia.jpg",
          hospitalName: "Phòng Khám Đa Khoa Nguyễn Huệ",
          hospitalId: "hospitalId",
          star: 4,
          experience: 4,
          information: "Đã có đóng góp lớn trong việc kiểm soát dịch COVID-19 tại Việt Nam, đặc biệt là trong giai đoạn đầu của đợt bùng phát dịch ở Đà Nẵng vào năm 2020. Ông đã đưa ra nhiều giải pháp quan trọng như tăng cường kiểm soát biên giới, áp dụng giãn cách xã hội và ủng hộ việc sử dụng ứng dụng truy vết F1 của Việt Nam",
          knowledges: ['Bằng cử nhân y khoa,Chứng chỉ chuyên môn,Chứng chỉ cấp cứu cơ bản,Chứng chỉ hậu cần'],
          fields: 'Chuyên Khoa Ngoại'
      ).toJson()
  ).then((value) {
    print("SUCCESS ${value.id}");
    id = value.id;
  });

  var reviews = [
                {
                  'star' : 4,
                  'review_day' : '20/04/2020',
                  'content' : 'Chất lượng khám bệnh tốt, thái độ phục vụ của nhân viên tốt.',
                  'user' : {
                      'id': 'mlVCFhU7gEiIxtBvjbAQ',
                      'full_name': 'Nguyễn Thị Nhàn',
                      'image': 'https://vapa.vn/wp-content/uploads/2022/12/anh-mau-dep-002.jpg'
                    },
                  },
                {
                  'star' : 4,
                  'review_day' : '20/08/2018',
                  'content' : 'Chất lượng khám bệnh tốt, thái độ phục vụ của nhân viên tốt, phòng khám sạch sẽ.',
                  'user' : {
                    'id': 'pZp19H6qsGnt9aPsjPRH',
                    'full_name': 'Trần Ngọc Hải',
                    'image': 'https://png.pngtree.com/thumb_back/fw800/background/20210903/pngtree-elderly-life-in-the-daytime-grandpa-holding-glasses-indoors-photography-map-image_792180.jpg'
                  },
                }
             ];

  for(int i = 0 ; i < 2 ; i++) {
    await fireStore.collection("doctors").doc(id).collection("reviews").add(
        reviews[i]
    );
  }

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
