/*
 * PRYNCE TV Ghana broadcaster directory screen.
 * This file is compiled into the pinned OpenTV Android app by the repository build workflow.
 * GPL-3.0-or-later; retain upstream notices when modifying upstream files.
 */
package app.opentv.ui

import android.content.Intent
import android.net.Uri
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.Card
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import org.json.JSONObject

private data class GhanaTvDestination(
    val name: String,
    val category: String,
    val description: String,
    val url: String,
)

@Composable
fun GhanaTvScreen() {
    val context = LocalContext.current
    val entries = remember(context) {
        runCatching {
            val json = context.assets.open("prynce-ghana-tv-directory.json")
                .bufferedReader().use { it.readText() }
            val array = JSONObject(json).getJSONArray("entries")
            buildList {
                for (i in 0 until array.length()) {
                    val item = array.getJSONObject(i)
                    val url = item.getString("destination")
                    if (url.startsWith("https://")) {
                        add(
                            GhanaTvDestination(
                                name = item.getString("name"),
                                category = item.optString("category", "TV"),
                                description = item.optString("playback", "Open official broadcaster page."),
                                url = url,
                            ),
                        )
                    }
                }
            }
        }.getOrDefault(emptyList())
    }

    Column(Modifier.fillMaxSize().padding(20.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
        Text("GHANA TV", style = MaterialTheme.typography.headlineMedium)
        Text(
            "Official broadcaster destinations. Live availability and access may depend on the broadcaster, your location and any required subscription.",
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
        )
        if (entries.isEmpty()) {
            Text("The directory is temporarily unavailable. Check your app update or internet connection.")
        } else {
            LazyColumn(verticalArrangement = Arrangement.spacedBy(10.dp)) {
                items(entries) { entry ->
                    Card(
                        Modifier.fillMaxWidth().clickable {
                            runCatching {
                                context.startActivity(
                                    Intent(Intent.ACTION_VIEW, Uri.parse(entry.url))
                                        .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK),
                                )
                            }
                        },
                    ) {
                        Column(Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(6.dp)) {
                            Text(entry.name, style = MaterialTheme.typography.titleLarge)
                            Text(entry.category, style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.primary)
                            Text(entry.description, style = MaterialTheme.typography.bodyMedium)
                            Text("OPEN OFFICIAL SITE  ›", style = MaterialTheme.typography.labelLarge, color = MaterialTheme.colorScheme.primary)
                        }
                    }
                }
            }
        }
    }
}
