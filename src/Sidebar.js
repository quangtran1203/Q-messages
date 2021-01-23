import React, { useEffect, useState } from 'react';
import "./Sidebar.css";
import ChatIcon from '@material-ui/icons/Chat';
import MoreVertIcon from '@material-ui/icons/MoreVert';
import DonutLargeIcon from '@material-ui/icons/DonutLarge';
import { IconButton, Avatar } from '@material-ui/core';
import { SearchOutlined } from '@material-ui/icons';
import SideChat from './SideChat';
import db from "./firebase";
import { useStateValue } from './StateProvider';


function Sidebar() {

    const [{ user }, dispatch] = useStateValue();
    const [search, setSearch] = useState("");

    const [rooms, setRooms] = useState([]);
    useEffect(() => {
        const unsubscribe = db.collection("rooms").onSnapshot(snapshot =>
            setRooms(snapshot.docs.map(doc => ({
                id: doc.id,
                data: doc.data()
            })))
        );
        return () => {
            unsubscribe();
        }
    }, []);

    return (
        <div className="sidebar">
            <div className="sidebar_header">
                <Avatar src={user?.photoURL}/>
                <div className="sidebar_headerRight">
                    <IconButton>
                        <DonutLargeIcon/>
                    </IconButton>
                    <IconButton>
                        <ChatIcon/>
                    </IconButton>
                    <IconButton>
                        <MoreVertIcon/>
                    </IconButton>
                </div>
            </div>

            <div className="sidebar_search">
                <div className="sidebar_searchContainer">
                    <SearchOutlined />
                    <input value={search} onChange={e => setSearch(e.target.value)} placeholder="Search for rooms" type="text"/>
                </div>
            </div>

            <div className="sidebar_chats">
                <SideChat addNew />
                
                {rooms.filter(room => {
                    return room.data.name.toLowerCase().includes(search.toLowerCase());
                })
                    .map(room => (<SideChat key={room.id} id={room.id} name={room.data.name} />))}
                
                
                {/*rooms.map(room => (
                    <SideChat key={room.id} id={room.id} name={room.data.name}/>
                ))*/}
            </div>
        </div>
    )
}

export default Sidebar
