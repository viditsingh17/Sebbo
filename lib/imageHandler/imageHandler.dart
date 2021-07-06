import 'package:firebase_storage/firebase_storage.dart' as f_s;
import 'package:image_picker/image_picker.dart';
import '../checkUser.dart';


class ImageHandler {

  handleImage(PickedFile file,String book,String name,String number) async {
    String mediaUrl = await uploadImage(file,book,name,number);
    return mediaUrl;
  }

  Future<String> uploadImage(imageFile,book,name,number) async {
     f_s.UploadTask uploadTask =
    storageRef.child('$number/$book/$name.jpg').putFile(imageFile);
    f_s.TaskSnapshot storageTaskSnapshot = uploadTask.snapshot;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

}
