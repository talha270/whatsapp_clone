simplevalidator({required String value}){
  if(value.isEmpty){
    return "this field is required";
  }else{
    return null;
  }
}

emailvalidator({required String value}) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  } else if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
    return 'Enter a valid email';
  }else if(!value.contains("@")){
    return "Enter a valid email";
  }else{
    return null;
  }
}

passwordvalidator ({required String value}) {
  if(value!.isEmpty){
    return "Password is required";
  }else if(value.length<7){
    return "password must contain 7 characters";
  }else{
    return null;
  }
}

reenterpasswordvalidator({required String value,required String match}){
  if(value!.isEmpty){
    return "Password is required.";
  }else if (value != match) {
    return "Password not match.";
  }else{
    return null;
  }
}