package com.example.myapplication3

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size // Cho Modifier.size()
import androidx.compose.material3.Text
import androidx.compose.ui.Alignment
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.example.myapplication3.ui.theme.MyApplication3Theme
import androidx.compose.ui.text.font.FontWeight



class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            MyApplication3Theme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    CenterImage(modifier = Modifier.padding(innerPadding))

                }
            }
        }
    }
}



@Composable
fun CenterImage(modifier: Modifier = Modifier){

    Box(

        modifier = modifier.fillMaxSize(),


        contentAlignment = Alignment.Center

    ) {


        Column(

            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Image(

                painter = painterResource(id = R.drawable.cute),


                contentDescription = "Hình ảnh ",
                modifier = Modifier.size(120.dp)

            )
            Text(
                text = "Lê Quang Pháp",
                fontWeight = FontWeight.Bold,
                fontSize = 18.sp,
                modifier = Modifier.padding(top = 16.dp)
            )

            Text(
                text = "Pháp đẹp số hai không ai số 1",
                fontSize = 14.sp,
                modifier = Modifier.padding(horizontal = 32.dp, vertical = 8.dp),
                textAlign = androidx.compose.ui.text.style.TextAlign.Center
            )
        }
    }
    @Composable
    fun Greeting(name: String, modifier: Modifier = Modifier) {
        Text(
            text = "",
            modifier = modifier
        )
    }




    MyApplication3Theme {
        Greeting("Android")
    }
}