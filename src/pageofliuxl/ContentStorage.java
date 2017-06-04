package pageofliuxl;

import java.util.HashMap;
import java.util.Map;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;

public class ContentStorage {

	protected MongoCollection collection = null;

	public static final ContentStorage instance = new ContentStorage();

	public static final String MONGODB_SERVER = "127.0.0.1:27017";
	
	public void save(String title, String content) {
		Document document = new Document();
		document.put("title", title);
		document.put("content", content);
		long timestamp = System.currentTimeMillis();
		document.put("timestamp", timestamp);
		collection.insertOne(document);
	}
	
	public Map<String, String> readAll(){
		Map<String, String> resultMap = new HashMap<>();
		Document document = new Document();
		Document sortType = new Document();
		sortType.put("timestamp", -1);
		MongoCursor<Document> cursor = collection.find(document).sort(sortType).iterator();
		while (cursor.hasNext()) {
			Document result = cursor.next();
			String title = result.getString("title");
			String content = result.getString("content");
			resultMap.put(title, content);
		}
		cursor.close();
		return resultMap;
	}
	
	private ContentStorage() {
		collection = new MongoClient(MONGODB_SERVER).getDatabase("pageofliuxl_debug").getCollection("blogContents");
	}
}
