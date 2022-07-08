import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tools/colors/string_to_color.dart';
import 'package:flutter_tools/converter/jwt_converter.dart';

const testToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJwbS10ZXN0LnJlYWxwYWQuZXUiLCJpYXQiOjE2NTYzMjU2OTIsIm5iZiI6MTY1NjMyNTY5MiwiZXhwIjoxNjU2NDEyMDkyLCJ1aWQiOjExMX0.B1wdmpBmfSHDQNdEYjWDpcfPrsEF_AusEJs2VQTVsaN9Ac0niDISaRkq2Y6X084A4BFk_aZ8l_LCSmB00wr7zLMhU_G9YzUudEqlZls9c51hrAIpNvg0cek4WYfH6oHWbOtyebziqJDgdd-UyjwCpLyFL1qduKJhXNR5mmav9siTaRXmZF4ocAns5JLlOGp-tS9mjczO8Z1jxjquQ_6Hznx9F9SVGaapFZRKgkSc3hjiYvTrUm1m8NvhVae8DM-AmsrNHUe2ceDaf0k_O8hySKO33DabjPeNkqsUHgd0LvCJEuNNUPvqDKRRx3cor8PS_FOxj1M0GyeEc7veCAAe4w";

void main() {
  test('Testing if string to color returns unique color', () {

    print(Jwt.parseJwt(testToken));

    expect(Jwt.getExpiryDate(testToken)?.millisecondsSinceEpoch, 1656412092*1000);
    expect(Jwt.isExpired(testToken), true);
  });
}