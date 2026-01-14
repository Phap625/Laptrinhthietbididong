package com.example.myapplication4

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.myapplication4.ui.theme.MyApplication4Theme


val CustomBlue = Color(0xFF42A5F5)
val CustomRed = Color(0xFFE53935)

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            MyApplication4Theme {
                PracticeScreen02()
            }
        }
    }
}
@Composable
fun PracticeScreen02() {
    var inputNumber by remember { mutableStateOf("") }


    var listCount by remember { mutableStateOf(0) }


    var errorMessage by remember { mutableStateOf<String?>(null) }

    Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
                .padding(horizontal = 16.dp, vertical = 24.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {


            Text(
                text = "Thực hành 02",
                style = MaterialTheme.typography.headlineMedium,
                fontWeight = FontWeight.Bold,
                modifier = Modifier.padding(bottom = 24.dp)
            )


            Column(modifier = Modifier.fillMaxWidth()) {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {

                    OutlinedTextField(
                        value = inputNumber,
                        onValueChange = { newValue ->

                            inputNumber = newValue
                        },
                        label = { Text("Nhập vào số lượng") },
                        isError = errorMessage != null,
                        modifier = Modifier.weight(1f)
                    )
                    Spacer(modifier = Modifier.width(8.dp))
                    Button(
                        onClick = {
                            errorMessage = null
                            listCount = 0


                            val trimmedInput = inputNumber.trim()
                            val number = trimmedInput.toIntOrNull()

                            if (number != null && number > 0) {
                                listCount = number
                            } else {
                                if (trimmedInput.isEmpty()) {
                                    errorMessage = "Vui lòng nhập số lượng"
                                } else {

                                    errorMessage = "Dữ liệu bạn nhập không hợp lệ. Vui lòng nhập lại."
                                }
                            }
                        },
                        colors = ButtonDefaults.buttonColors(containerColor = CustomBlue),
                        modifier = Modifier.height(56.dp)
                    ) {
                        Text("Tạo")
                    }
                }

                // Hiển thị thông báo lỗi
                if (errorMessage != null) {
                    Text(
                        text = errorMessage!!,
                        color = MaterialTheme.colorScheme.error,
                        style = MaterialTheme.typography.bodySmall,
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(top = 4.dp)
                    )
                }
            }

            Spacer(modifier = Modifier.height(24.dp))


            if (listCount > 0) {
                LazyColumn(
                    modifier = Modifier.fillMaxWidth(),
                    verticalArrangement = Arrangement.spacedBy(10.dp)
                ) {

                    items(items = (1..listCount).toList()) { index ->
                        ListItemCard(index = index)
                    }
                }
            }
        }
    }
}

/**
 * Hàm Composable để tạo một mục trong danh sách (giống nút màu đỏ trong hình)
 */
@Composable
fun ListItemCard(index: Int) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        shape = RoundedCornerShape(12.dp),

        colors = CardDefaults.cardColors(containerColor = CustomRed)
    ) {
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 16.dp),
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = "$index",
                color = Color.White,
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.SemiBold
            )
        }
    }
}


@Preview(showBackground = true)
@Composable
fun PracticeScreen02Preview() {
    MyApplication4Theme {
        PracticeScreen02()
    }
}