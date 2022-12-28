import { useState } from "react";
import { ethers ,BigNumber } from "ethers";
import roboPunksNFT from "./RoboPunksNFT.json";
import { boolean } from "hardhat/internal/core/params/argumentTypes";

const roboPunksNFTAddress = "0x5711F24Be324B347DaCe6D42caA4E08841cCCDbD";

const MainMint = ({accounts , setAccounts}) =>{

    const [mintAmount , setMintAmount] = useState(1);
    const isConnected = boolean(accounts[0]);

    async function handleMint(){
        if(window.ethereum){
            const provider = new ethers.providers.Web3Provider(window.ethereum);
            const signer = provider.getSigner();
            const contract = new ethers.Contract(
                roboPunksNFTAddress,
                roboPunksNFT.abi,
                signer
            ) ;
            try{
                const response = await contract.mint(BigNumber.from(mintAmount));
                console.log("Response:",response);
                alert("Response:",response);
            }catch(err){
                console.log("error:",err);
                alert("error:",err);
            }
        }
    }



    const handleDecrement = () =>{
        if(mintAmount <=1){
            return;
        }
        setMintAmount = (mintAmount -1);
    };

    const handleIncrement = () =>{
        if(mintAmount >= 3){
            return;
        }
        setMintAmount = (mintAmount +1);
    };



    return (
        <div>
            <h1>LonePunks</h1>
            <p>
                Save Earth for NFT Speculation . Mint LonePunks to contribute.
            </p>
            {isConnected ? (
            <div>
               <div>
               <button onClick={handleDecrement}>-</button>
               <input type="number" value={mintAmount} />

               <button onClick={handleIncrement}>+</button>
               </div>
               <button onClick={handleMint}>Mint Now</button>
            </div>
            )
        :   (
            <p>
                You must be connected to Mint.
            </p>
            )
         };
        </div>
    );
};


export default MainMint;