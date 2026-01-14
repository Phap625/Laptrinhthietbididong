package com.example.myapplication7

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.myapplication7.ui.theme.MyApplication7Theme


val PlusColor = Color(0xFFE53935)
val MinusColor = Color(0xFFFFCC33)
val MultiplyColor = Color(0xFF6A1B9A)
val DivideColor = Color(0xFF263238)

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            MyApplication7Theme {
                CalculatorScreen()
            }
        }
    }
}



fun calculateResult(num1Str: String, num2Str: String, operation: String?): String {
    if (operation == null) {
        return "Chọn một phép toán"
    }

    val num1 = num1Str.replace(',', '.').toDoubleOrNull()
    val num2 = num2Str.replace(',', '.').toDoubleOrNull()

    if (num1 == null || num2 == null) {
        if (num1Str.isBlank() || num2Str.isBlank()) {
            return "..."
        }
        return "Lỗi nhập liệu số"
    }

    val result = when (operation) {
        "+" -> num1 + num2
        "-" -> num1 - num2
        "x" -> num1 * num2
        "/" -> {
            if (num2 == 0.0) {
                return "Không chia cho 0"
            }
            num1 / num2
        }
        else -> return "Lỗi phép toán"
    }

    return if (result == result.toLong().toDouble()) {
        result.toLong().toString()
    } else {
        String.format("%.2f", result)
    }
}



@Composable
fun CalculatorScreen() {
    var soThuNhat by remember { mutableStateOf("") }
    var soThuHai by remember { mutableStateOf("") }
    var phepToanDaChon by remember { mutableStateOf<String?>(null) }

    val ketQua = remember(soThuNhat, soThuHai, phepToanDaChon) {
        calculateResult(soThuNhat, soThuHai, phepToanDaChon)
    }

    Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
        Column(
            modifier = Modifier
                .padding(innerPadding)
                .padding(horizontal = 24.dp, vertical = 32.dp)
                .fillMaxSize(),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text(
                text = "Thực hành 03",
                fontSize = 22.sp,
                fontWeight = FontWeight.Bold,
                modifier = Modifier.padding(bottom = 32.dp)
            )

            CustomTextField(
                value = soThuNhat,
                onValueChange = { soThuNhat = it },
                label = "Nhập số thứ nhất"
            )

            Spacer(modifier = Modifier.height(16.dp))

            OperationButtons(
                selectedOperation = phepToanDaChon,
                onOperationSelected = { phepToanDaChon = it }
            )

            Spacer(modifier = Modifier.height(16.dp))

            CustomTextField(
                value = soThuHai,
                onValueChange = { soThuHai = it },
                label = "Nhập số thứ hai"
            )

            Spacer(modifier = Modifier.height(60.dp))

            Text(
                text = "Kết quả:",
                fontSize = 18.sp,
                fontWeight = FontWeight.SemiBold
            )
            Text(
                text = ketQua,
                fontSize = 40.sp,
                fontWeight = FontWeight.ExtraBold,
                color = MaterialTheme.colorScheme.primary,
                modifier = Modifier.padding(top = 4.dp)
            )
        }
    }
}


@Composable
fun CustomTextField(value: String, onValueChange: (String) -> Unit, label: String) {
    OutlinedTextField(
        value = value,
        onValueChange = onValueChange,
        label = { Text(text = label) },
        keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal),
        singleLine = true,
        modifier = Modifier.fillMaxWidth()
    )
}

@Composable
fun OperationButtons(selectedOperation: String?, onOperationSelected: (String) -> Unit) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp),
        horizontalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        val operations = listOf(
            "+" to PlusColor,
            "-" to MinusColor,
            "x" to MultiplyColor,
            "/" to DivideColor
        )

        operations.forEach { (op, color) ->
            OperationButton(
                operation = op,
                color = color,
                isSelected = selectedOperation == op,
                onClick = { onOperationSelected(op) },
                modifier = Modifier.weight(1f)
            )
        }
    }
}
 
@Composable
fun OperationButton(
    operation: String,
    color: Color,
    isSelected: Boolean,
    onClick: () -> Unit,
    modifier: Modifier = Modifier
) {
    val containerColor = if (isSelected) color else MaterialTheme.colorScheme.surfaceVariant
    val contentColor = if (isSelected) Color.White else MaterialTheme.colorScheme.onSurface

    Button(
        onClick = onClick,
        modifier = modifier
            .height(48.dp)
            .padding(vertical = 4.dp),
        shape = RoundedCornerShape(8.dp),
        colors = ButtonDefaults.buttonColors(containerColor = containerColor, contentColor = contentColor),
        contentPadding = PaddingValues(0.dp)
    ) {
        Box(
            modifier = Modifier
                .fillMaxSize(),
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = operation,
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun CalculatorPreview() {
    MyApplication7Theme {
        CalculatorScreen()
    }
}
