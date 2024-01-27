import 'package:app/global_resource.dart';

Widget formUndangan(s, context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 130, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('invitation_title'),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr('login_validation_email');
                  }
                  return null;
                },
                autofocus: true,
                onChanged: (value) => s.emailUndangan = value,
                keyboardType: TextInputType.emailAddress,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                decoration: InputDecoration(
                  hintText: tr('invitation_hint_email'),
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: colorBluePrimary, width: 1.5),
                  ),
                ),
              ),
            ),
            Text(
              tr('invitation_help_email'),
              style: const TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    ],
  );
}
