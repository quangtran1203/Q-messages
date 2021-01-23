import { Button } from '@material-ui/core';
import React from 'react';
import { auth, provider } from './firebase';
import "./Login.css";
import { actionTypes } from './reducer';
import { useStateValue } from './StateProvider';

function Login() {

    const [{}, dispatch] = useStateValue();

    const signIn = () => {
        auth.signInWithPopup(provider).then(result => {
            dispatch({
                type: actionTypes.SET_USER,
                user: result.user,
            });
            alert("Signed in successfully!");
        })
            .catch(err => alert(err.message));
    };

    return (
        <div className="login">
            <div className="login_container">
                <h1 className="login_title">Q-messages</h1>
                <div className="login_text">
                    <h2>Sign In to Q-messages</h2>
                </div>

                <Button type="submit" onClick={signIn}>
                    Sign In with Google
                </Button>
            </div>

            <p>&#169; 2021 - Quang Tran</p>
        </div>
    )
}

export default Login
