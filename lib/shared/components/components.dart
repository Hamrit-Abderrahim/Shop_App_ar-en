import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/moduls/details_screen/details_screen.dart';
import 'package:shop_app/shared/style/color.dart';

//*********NavigateAndReplace***************
void navigateAndReplace(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}

//*********Navigate To***************
void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

//........MyDivider............
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

//...........defaultFormField..........
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  //Function? validate,
  FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      validator: validate,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffC9C9C9), width: 1.0),
        ),
        errorStyle: TextStyle(fontSize: 18),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color:Colors.red, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff0e93a7), width: 1.0),
        ),
        contentPadding: const EdgeInsets.all(10),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 21,
          color: const Color(0xff6A6A6A),
        ),
        hintStyle: TextStyle(
          fontSize: 21,
        ),
        prefixIcon: Icon(prefix, size: 20),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 0.0),
        ),
      ),
    );
//.............defaultButton.........
Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        color: defaultColor,
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: defaultColor,
      ),
    );
//.............defaultTextButton.........
Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: function()!,
      child: Text(
        text.toUpperCase(),
      ),
    );
//.............showToast............
void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        //هذي ل android lenght_long 5s
        gravity: ToastGravity.BOTTOM,
        //مكان ظهورها في الشاشة
        timeInSecForIosWeb: 5,
        //هذا ل ios and web
        backgroundColor: chooseToastColor(state),
        textColor: Colors.black,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

//************buildListProductItem*********************
Widget buildListProductItem(products, context) => InkWell(
  onTap: (){
    navigateTo(context, DetailsScreen(products.id));
  },
  child:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Image(
                    image: NetworkImage('${products.image}'),
                    width: 120,
                    height: 120,
                  ),
                  if (products.discount != 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        color: Colors.red,
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    )
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${products.name}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${products.price}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: defaultColor,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (products.discount != 0)
                          Text(
                            '${products.oldPrice}',
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.bold),
                          ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              AppCubit.get(context).changeFavourites(products.id);
                            },
                            icon: CircleAvatar(
                                backgroundColor: AppCubit.get(context)
                                            .favorites[products.id] ==
                                        true
                                    ? defaultColor
                                    : Colors.grey,
                                radius: 15.0,
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                  size: 14.0,
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
);
