import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ForgotPasswordScreen(),
  ));
}

// --- CLASS DÙNG ĐỂ CHỨA KẾT QUẢ TRẢ VỀ ---
class FormData {
  final String email;
  final String otp;
  final String password;

  FormData({required this.email, required this.otp, required this.password});
}

// --- CÁC WIDGET DÙNG CHUNG ---

class BrandingHeader extends StatelessWidget {
  const BrandingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Image.asset(
          'assets/logo.png',
          height: 80,
          errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.school, size: 80, color: Colors.green),
        ),
        const SizedBox(height: 10),
        const Text(
          "SmartTasks",
          style: TextStyle(color: Color(0xFF2196F3), fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2196F3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}

// Nâng cấp thành TextFormField để bắt lỗi
class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool readOnly;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      readOnly: readOnly,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }
}

// --- MÀN HÌNH 1: FORGET PASSWORD ---
class ForgotPasswordScreen extends StatefulWidget {
  final FormData? returnedData;
  const ForgotPasswordScreen({super.key, this.returnedData});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 60),
                const BrandingHeader(),
                const Text("Forget Password?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Enter your Email to verify.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 30),

                // Nhập Email có Validate
                CustomTextFormField(
                  hintText: "Your Email",
                  icon: Icons.email_outlined,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Vui lòng nhập email";
                    if (!value.contains("@")) return "Email không hợp lệ!";
                    return null;
                  },
                ),

                const SizedBox(height: 30),
                PrimaryButton(
                  text: "Next",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Chuyển màn hình và truyền Email đi
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VerifyCodeScreen(email: _emailController.text),
                        ),
                      );
                    }
                  },
                ),

                // --- PHẦN HIỂN THỊ DỮ LIỆU TRẢ VỀ (NẾU CÓ) ---
                if (widget.returnedData != null) ...[
                  const SizedBox(height: 40),
                  const Divider(),
                  const Text("THÔNG TIN ĐÃ NHẬP TRƯỚC ĐÓ:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email: ${widget.returnedData!.email}"),
                        Text("OTP: ${widget.returnedData!.otp}"),
                        Text("Password: ${widget.returnedData!.password}"),
                      ],
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- MÀN HÌNH 2: VERIFICATION ---
class VerifyCodeScreen extends StatefulWidget {
  final String email; // Nhận email từ màn trước
  const VerifyCodeScreen({super.key, required this.email});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  // Tạo 6 controller cho 6 ô nhập
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());

  // Hàm kiểm tra và lấy mã OTP
  String? getOTP() {
    String otp = "";
    for (var controller in _controllers) {
      if (controller.text.isEmpty) return null; // Chưa nhập đủ
      otp += controller.text;
    }
    return otp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const BrandingHeader(),
            const Text("Verify Code", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Code sent to: ${widget.email}", textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),

            // 6 ô nhập OTP
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) => SizedBox(
                width: 45, height: 50,
                child: TextField(
                  controller: _controllers[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  decoration: InputDecoration(
                    counterText: "", // Ẩn bộ đếm số ký tự
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  ),
                  onChanged: (value) {
                    // Tự động nhảy sang ô tiếp theo khi nhập
                    if (value.isNotEmpty && index < 5) FocusScope.of(context).nextFocus();
                    // Tự động lùi lại khi xóa (nếu cần xử lý phức tạp hơn thì dùng package pinput)
                    if (value.isEmpty && index > 0) FocusScope.of(context).previousFocus();
                  },
                ),
              )),
            ),

            const Spacer(),
            PrimaryButton(
              text: "Next",
              onPressed: () {
                String? otp = getOTP();
                if (otp != null && otp.length == 6) {
                  // Đủ 6 số -> Chuyển màn hình
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => ResetPasswordScreen(email: widget.email, otp: otp),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vui lòng nhập đủ 6 số OTP")));
                }
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// --- MÀN HÌNH 3: RESET PASSWORD ---
class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPasswordScreen({super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const BrandingHeader(),
              const Text("Create new password", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),

              CustomTextFormField(
                hintText: "Password", icon: Icons.lock_outline, isPassword: true,
                controller: _passController,
                validator: (val) => (val!.length < 6) ? "Mật khẩu quá ngắn" : null,
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                hintText: "Confirm Password", icon: Icons.lock_outline, isPassword: true,
                controller: _confirmPassController,
                validator: (val) {
                  if (val != _passController.text) return "Mật khẩu không khớp"; // Kiểm tra khớp
                  return null;
                },
              ),

              const Spacer(),
              PrimaryButton(
                text: "Next",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => ConfirmScreen(
                          email: widget.email,
                          otp: widget.otp,
                          password: _passController.text
                      ),
                    ));
                  }
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// --- MÀN HÌNH 4: CONFIRM ---
class ConfirmScreen extends StatelessWidget {
  final String email;
  final String otp;
  final String password;

  const ConfirmScreen({super.key, required this.email, required this.otp, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.black)),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const BrandingHeader(),
              const Text("Confirm", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),

              // Hiển thị dữ liệu đã nhập (ReadOnly)
              CustomTextFormField(hintText: "", icon: Icons.email, controller: TextEditingController(text: email), readOnly: true),
              const SizedBox(height: 15),
              CustomTextFormField(hintText: "", icon: Icons.check_circle, controller: TextEditingController(text: otp), readOnly: true),
              const SizedBox(height: 15),
              CustomTextFormField(hintText: "", icon: Icons.lock, controller: TextEditingController(text: password), isPassword: true, readOnly: true),

              const Spacer(),
              PrimaryButton(
                text: "Submit",
                onPressed: () {
                  // QUAY LẠI MÀN HÌNH ĐẦU VÀ TRUYỀN DỮ LIỆU
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ForgotPasswordScreen(
                        returnedData: FormData(email: email, otp: otp, password: password),
                      ),
                    ),
                        (route) => false, // Xóa hết lịch sử back cũ
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        )
    );
  }
}
