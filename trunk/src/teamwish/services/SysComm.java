package teamwish.services;

import java.io.IOException;
import java.io.InputStream;

import java.util.Map;
import java.util.Set;
import java.util.Stack;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.atomic.AtomicInteger;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;


@ServerEndpoint(value = "/SysComm")
public class SysComm {

	

	private static InputStream in;
	static Thread t;	
	private static final String GUEST_PREFIX = "Guest";
	private static final AtomicInteger connectionIds = new AtomicInteger(0);
	public static final Stack ClientMessage = new Stack();
	private static final Set<SysComm> connections = new CopyOnWriteArraySet<>();

	private final String nickname;
	private Session session;
	static Map map;
	public SysComm() {
		nickname = GUEST_PREFIX + connectionIds.getAndIncrement();
	}

	@OnOpen
	public void start(Session session) {
		this.session = session;
		connections.add(this);
		String info = String.format("* %s %s", nickname, "has joined.");
		//broadcast(info);
	
		//PushMessage(message);
	}
	public void ResetSock()
	{
		
	}
	
	@OnClose
	public void end() {
		connections.remove(this);

		String message = String.format("* %s %s", nickname, "has disconnected.");
		broadcast(message);
		if (connections.size() == 0) {
			
		}
	}	
	
	private void PushMessage(String line) {
		
		String[] result = line.split("\\^");
		String info="";
		byte[] data;
		
		try {
			/*
			 * lock.lock(); ClientMessage.push(message); lock.unlock();
			 */
			
			System.out.println("[Client]: " + info);

			// ˢ�������,ʹClient�����յ����ַ���
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}

	}

	
	@OnMessage
	public void incoming(String message) {
		// message = String.format("* %s:%s", nickname,message);
		PushMessage(message);
		// Never trust the client

		//broadcast(message);
	}

	@OnError
	public void onError(Throwable t) throws Throwable {
		//System.out.print("Chat Error: " + t.toString(), t);
	}

	public void broadcast(String msg) {
		for (SysComm client : connections) {
			try {
				synchronized (client) {
					client.session.getBasicRemote().sendText(msg);
				}
			} catch (IOException e) {
				
				connections.remove(client);
				try {
					client.session.close();
				} catch (IOException e1) {
					// Ignore
				}
				String message = String.format("* %s %s", client.nickname, "has been disconnected.");
				broadcast(message);
			}
		}
	}
}
