package pageofliuxl;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.bson.Document;
import org.bson.types.ObjectId;
import org.json.JSONArray;
import org.json.JSONObject;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;

public class MessageStorage {
	protected volatile int unreadMessageCount;

	protected volatile int messageCount;

	private Object countLock = new Object();

	protected MongoCollection<Document> collection = null;

	public static final MessageStorage instance = new MessageStorage();

	public static final String MONGODB_SERVER = "localhost:27017";

	public int getUnreadMessageCount() {
		return unreadMessageCount;
	}

	public void save(String ip, String title, String content, boolean flag) {
		Document document = new Document();
		document.put("ip", ip);
		document.put("title", title);
		document.put("content", content);
		document.put("flag", flag);
		long timestamp = System.currentTimeMillis();
		document.put("timestamp", timestamp);
		collection.insertOne(document);
		synchronized (countLock) {
			messageCount++;
			unreadMessageCount++;
		}
	}

	public JSONObject read(String id) {
		Document document = new Document();
		document.put("_id", new ObjectId(id));
		MongoCursor<Document> cursor = collection.find(document).iterator();
		JSONObject jsonObject = new JSONObject();
		if (cursor.hasNext()) {
			Document result = cursor.next();
			jsonObject.put("ip", result.getString("ip"));
			jsonObject.put("title", result.getString("title"));
			jsonObject.put("content", result.getString("content"));
			Date date = new Date(result.getLong("timestamp"));
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String time = simpleDateFormat.format(date);
			jsonObject.put("time", time);
			if(result.getBoolean("flag") == false){
				Document documentUpdate = new Document();
				documentUpdate.put("_id", new ObjectId(id));
				documentUpdate.put("flag", true);
				Document documentNew = new Document("$set", documentUpdate);
				collection.updateOne(document, documentNew);
				synchronized(countLock){
					unreadMessageCount--;
				}
			}
		}
		cursor.close();
		return jsonObject;
	}

	public JSONArray readUnread() {
		Document document = new Document();
		document.put("flag", false);
		Document sortType = new Document();
		sortType.put("timestamp", -1);
		MongoCursor<Document> cursor = collection.find(document).sort(sortType).iterator();
		JSONArray jsonArray = new JSONArray();

		while (cursor.hasNext()) {
			Document result = cursor.next();
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", result.get("_id").toString());
			jsonObject.put("ip", result.getString("ip"));
			jsonObject.put("title", result.getString("title"));
			jsonObject.put("content", result.getString("content"));
			Date date = new Date(result.getLong("timestamp"));
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String time = simpleDateFormat.format(date);
			jsonObject.put("time", time);
			jsonArray.put(jsonObject);
		}
		cursor.close();
		return jsonArray;
	}

	public JSONArray readAll() {
		JSONArray jsonArray = new JSONArray();
		Document document = new Document();
		Document sortType = new Document();
		sortType.put("timestamp", -1);
		MongoCursor<Document> cursor = collection.find(document).sort(sortType).iterator();
		while (cursor.hasNext()) {
			JSONObject jsonObject = new JSONObject();
			Document result = cursor.next();
			jsonObject.put("id", result.get("_id").toString());
			jsonObject.put("ip", result.getString("ip"));
			jsonObject.put("title", result.getString("title"));
			jsonObject.put("content", result.getString("content"));
			jsonObject.put("flag", result.getBoolean("flag"));
			Date date = new Date(result.getLong("timestamp"));
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String time = simpleDateFormat.format(date);
			jsonObject.put("time", time);
			jsonArray.put(jsonObject);
		}
		cursor.close();
		return jsonArray;
	}

	private void initMessageCount() {
		Document document = new Document();
		MongoCursor<Document> cursor = collection.find(document).iterator();
		int countUnread = 0, countAll = 0;
		while (cursor.hasNext()) {
			if (cursor.next().getBoolean("flag") == false) {
				countUnread++;
			}
			countAll++;
		}
		this.unreadMessageCount = countUnread;
		this.messageCount = countAll;
	}

	private MessageStorage() {
		collection = new MongoClient(MONGODB_SERVER).getDatabase("pageofliuxl_debug").getCollection("messageContents");
		initMessageCount();
	}
}
