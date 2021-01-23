import React, { useEffect, useState } from 'react';
import "./MainChat.css";
import { Avatar, IconButton } from '@material-ui/core';
import { AttachFile, InsertEmoticon, MoreVert, SearchOutlined } from '@material-ui/icons';
import SendIcon from '@material-ui/icons/Send';
import MicIcon from '@material-ui/icons/Mic';
import { useParams } from 'react-router-dom';
import db from './firebase';
import firebase from "firebase";
import { useStateValue } from './StateProvider';


function MainChat() {

    const [{ user }, dispatch] = useStateValue();

    const [input, setInput] = useState("");
    const [seed, setSeed] = useState("");
    const [room, setRoom] = useState("");
    const [messages, setMessages] = useState([]);
    const { roomId } = useParams();

    useEffect(() => {
        if (roomId) {
            db.collection("rooms").doc(roomId).onSnapshot(snap => (
                setRoom(snap.data().name)
            ));
            db.collection("rooms").doc(roomId).collection("messages")
                .orderBy('timestamp', 'asc')
                .onSnapshot(snap => (
                    setMessages(snap.docs.map(doc => doc.data()))
            ))
        }
    }, [roomId]);

    useEffect(() => {
        setSeed(Math.floor(Math.random()*2200))
    }, [roomId]);

    const sendMessage = (e) => {
        e.preventDefault();
        //console.log("input received");
        db.collection("rooms").doc(roomId).collection("messages")
            .add({
                message: input,
                name: user.displayName,
                timestamp: firebase.firestore.FieldValue.serverTimestamp(),
        })
        setInput("");
    };

    return (
        <div className="mainchat">
            <div className="mainchat_header">
                <Avatar src={`https://avatars.dicebear.com/api/avataaars/${seed}.svg`}/>
                <div className="mainchat_headerInfo">
                    <h3>{room}</h3>
                    <p>
                       Last active {new Date(messages[messages.length-1]?.timestamp?.toDate()).toUTCString()}
                    </p>
                </div>

                <div className="mainchat_headerRight">
                    <IconButton>
                        <SearchOutlined/>
                    </IconButton>
                    <IconButton>
                        <AttachFile/>
                    </IconButton>
                    <IconButton>
                        <MoreVert/>
                    </IconButton>
                </div>
            </div>

            <div className="mainchat_body">
                {messages.map(message => (
                    <p className={`mainchat_message ${message.name === user.displayName && "mainchat_receiver"}`}>
                        <span className="mainchat_name">{message.name}</span>
                        {message.message}
                        <span className="mainchat_timestamp">
                            {new Date(message.timestamp?.toDate()).toUTCString()}
                        </span>
                    </p>
                ))}
                
            </div>

            <div className="mainchat_footer">
                <InsertEmoticon />
                <form>
                    <input value={input} onChange={e => setInput(e.target.value)} placeholder="Send a message...." type="text" />
                    <button onClick={sendMessage} type="submit"><SendIcon/></button>
                </form>
                <MicIcon/>
            </div>
        </div>
    )
}

export default MainChat
