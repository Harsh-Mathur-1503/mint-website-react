import { any, boolean } from "hardhat/internal/core/params/argumentTypes";
import React from "react";

const NavBar = ({accounts , setAccounts}) =>{
    const isConnected = boolean(accounts[0]);

    async function connectAccount(){
        if(window.ethereum){
            const accounts = await window.ethereum.request({
                method:"eth_requestAccounts",
            });
            setAccounts(accounts);
        }
    }

    return <div>
        {/* Left Side is Social Media Icons */}
        <div>Facebook</div>
        <div>Twitter</div>
        <div>Email</div>



        {/* Right Side sections and connect */}
        <div>About</div>
        <div>Mint</div>
        <div>Team</div>


        {/* Connect button */}
        {isConnected ?(
        <p>Connected</p>
        )
        :(
        <button onClick={connectAccount}>Connect</button>
        )

        
    }
    </div>
};


export default NavBar;