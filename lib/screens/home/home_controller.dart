import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  PageController pageController = PageController();
  List<String> slideshows = [];
  List<Map<String,dynamic>> categorys = [];
  List<Map<String,dynamic>> foods = [];
   @override
  void onInit() {
    
    super.onInit();
    slideshows = [
        'https://scontent.fdad3-6.fna.fbcdn.net/v/t39.30808-6/330153048_843374593423192_3337354632792068806_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=6WuAOgq9z-4AX8Tn39H&_nc_ht=scontent.fdad3-6.fna&oh=00_AfDHL7dgCq9s8Sq8dBbGqnhPIALQ7RW6qo0W26Ju6edJzw&oe=63F86AE7',
        'https://scontent.fdad3-6.fna.fbcdn.net/v/t39.30808-6/329104701_1907214276292127_8684554490442152967_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=IdT0nygKuVIAX9CP6NG&_nc_ht=scontent.fdad3-6.fna&oh=00_AfBQs9De-PAbbulVJU0YBEJiqAmHeaPwbKel21sYzZTwYA&oe=63F84670',
        'https://scontent.fdad3-6.fna.fbcdn.net/v/t39.30808-6/331557838_526085969512600_2368263493703371639_n.jpg?stp=cp6_dst-jpg&_nc_cat=1&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=DlXUc1H0Ws4AX92tnCS&_nc_ht=scontent.fdad3-6.fna&oh=00_AfDsuGi4iC18tWXEI8UMIivz3x-zlPg6I1ARfGCwshYHtA&oe=63F78A30'
    ];

    categorys = [
      {'id':1,'icon':'https://img.lovepik.com/original_origin_pic/18/06/14/02796094155598923676c4366fa8be86.png_wh860.png','title':'Cơm'},
      {'id':1,'icon':'https://image.shutterstock.com/shutterstock/photos/1842865540/display_1500/stock-vector-noodle-in-bowl-vector-design-chopstiks-with-noodle-1842865540.jpg','title':'Bún'},
      {'id':1,'icon':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQugmRCmTk-cQi2Rwct4aKh5PZAbQ985ZvG4zrf6DBqp6hFnL24_GRTUg7FAbXTY5K3C2c&usqp=CAU','title':'Mỳ'},
      {'id':1,'icon':'https://png.pngtree.com/png-vector/20210412/ourlarge/pngtree-shrimp-vector-png-image_3196434.jpg','title':'Đồ nhậu'},
      {'id':1,'icon':'https://img.lovepik.com/element/40052/6148.png_860.png','title':'Trà sửa'},
      {'id':1,'icon':'https://st.depositphotos.com/1332722/1245/v/950/depositphotos_12454057-stock-illustration-pizza-vector-illustration.jpg','title':'Ăn vặt'},
      {'id':1,'icon':'https://img.pikbest.com/png-images/qianku/eating-hot-pot-at-home_2400223.png!bw340','title':'Giải khát'},
      {'id':1,'icon':'https://media.istockphoto.com/id/1144407835/vi/vec-to/c%C3%A1-chi%C3%AAn-vector-m%C3%B3n-n%C6%B0%E1%BB%9Bng.jpg?s=1024x1024&w=is&k=20&c=XCIExnY15SuDwf1LSnouem_F1ZWIJU7OWKfQYnfdxEQ=','title':'Món chay'},
      
    ];

    foods = [
      {'id':1,'image':'https://scontent.xx.fbcdn.net/v/t1.15752-9/258503865_314608733608398_8600936457127769850_n.png?stp=dst-png_p206x206&_nc_cat=109&ccb=1-7&_nc_sid=aee45a&_nc_ohc=Bd-9OERq7UMAX-h2MMp&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_AdRAwAAf1-8oe3GyGsfe5dw5m8zkn8UeLsRho7bE-sHEMw&oe=641A588F','name':'Food','price':'45000'},
      {'id':1,'image':'https://scontent.xx.fbcdn.net/v/t1.15752-9/258503865_314608733608398_8600936457127769850_n.png?stp=dst-png_p206x206&_nc_cat=109&ccb=1-7&_nc_sid=aee45a&_nc_ohc=Bd-9OERq7UMAX-h2MMp&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_AdRAwAAf1-8oe3GyGsfe5dw5m8zkn8UeLsRho7bE-sHEMw&oe=641A588F','name':'Food','price':'45000'},
      {'id':1,'image':'https://scontent.xx.fbcdn.net/v/t1.15752-9/258503865_314608733608398_8600936457127769850_n.png?stp=dst-png_p206x206&_nc_cat=109&ccb=1-7&_nc_sid=aee45a&_nc_ohc=Bd-9OERq7UMAX-h2MMp&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_AdRAwAAf1-8oe3GyGsfe5dw5m8zkn8UeLsRho7bE-sHEMw&oe=641A588F','name':'Food','price':'45000'},
      {'id':1,'image':'https://scontent.xx.fbcdn.net/v/t1.15752-9/258503865_314608733608398_8600936457127769850_n.png?stp=dst-png_p206x206&_nc_cat=109&ccb=1-7&_nc_sid=aee45a&_nc_ohc=Bd-9OERq7UMAX-h2MMp&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_AdRAwAAf1-8oe3GyGsfe5dw5m8zkn8UeLsRho7bE-sHEMw&oe=641A588F','name':'Food','price':'45000'},
      {'id':1,'image':'https://scontent.xx.fbcdn.net/v/t1.15752-9/258503865_314608733608398_8600936457127769850_n.png?stp=dst-png_p206x206&_nc_cat=109&ccb=1-7&_nc_sid=aee45a&_nc_ohc=Bd-9OERq7UMAX-h2MMp&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_AdRAwAAf1-8oe3GyGsfe5dw5m8zkn8UeLsRho7bE-sHEMw&oe=641A588F','name':'Food','price':'45000'},
      {'id':1,'image':'https://scontent.xx.fbcdn.net/v/t1.15752-9/258503865_314608733608398_8600936457127769850_n.png?stp=dst-png_p206x206&_nc_cat=109&ccb=1-7&_nc_sid=aee45a&_nc_ohc=Bd-9OERq7UMAX-h2MMp&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_AdRAwAAf1-8oe3GyGsfe5dw5m8zkn8UeLsRho7bE-sHEMw&oe=641A588F','name':'Food','price':'45000'},
     
    ];
  }
}