import { Avatar } from '@material-ui/core';
import React, { useEffect, useState } from 'react';
import db from './firebase';
import "./SideChat.css";
import { Link } from "react-router-dom";

function SideChat({ addNew, id, name }) {

    const [messages, setMessages] = useState("");
    useEffect(() => {
        if (id) {
            db.collection("rooms").doc(id).collection("messages")
                .orderBy("timestamp", "desc")
                .onSnapshot(snap => (
                    setMessages(snap.docs.map(doc => doc.data()))
                ));
        }
    }, [id]);

    const truncate = (str, n) => {
        return str?.length > n ? str.substr(0, n - 1) + " ...." : str;
    };
    
    const createChat = () => {
        const roomName = prompt("Please enter a name for this new room: ");
        if (roomName) {
            db.collection("rooms").add({
                name: roomName,
            })
        }
    };

    const [seed, setSeed] = useState("");
    useEffect(() => {
        setSeed(Math.floor(Math.random()*2000))
    }, []);

    return !addNew ? (
        <Link to={`/rooms/${id}`}>
        <div className="sidechat">
            <Avatar src={`https://avatars.dicebear.com/api/bottts/${seed}.svg`}/>
            <div className="sidechat_info">
                <h2>{name}</h2>
                    <p>
                     {truncate(messages[0]?.message, 35)}   
                </p>
            </div>
            </div>
        </Link>
    ) : (
            <div onClick={createChat} className="sidechat">
                <h3>Add New Room</h3>
            </div>
    )
}

export default SideChat
