contract;

use std::{
    auth::msg_sender,
    hash::Hash,
    storage::{
        storage_bytes::*,
        storage_string::*,
        storage_vec::*,
    },
    string::String,
};


abi ThirdContract {
    #[storage(read)]
    fn get_eligible(identity: Identity) -> bool;
}
//implement Interface, can upgrade when need

abi NameContract {
    #[storage(read)]
    fn get_name(identity: Identity) -> Option<String>;
}


storage{
    name_contract_id: b256 = 0xb9d62dec6e8b87e495772cd81862db31394bfc3b4d1cb6e04c530f21e3ac1f80,
}

impl ThirdContract for Contract {
    #[storage(read)]
    fn get_eligible(identity: Identity) -> bool{
        let identity = msg_sender().unwrap();
        let name_contract = abi(NameContract, storage.name_contract_id.read());
        let myname = name_contract.get_name(identity); 
        if myname.is_some() {
            return true;
        }else{
            return false;
        }
    }
}
