package com.util.smallglobal
{
    import com.game.utils.*;
    import com.model.*;

    public class SmallGlobalImpl extends SmallGlobal
    {

        public function SmallGlobalImpl()
        {
            instance = this;
            return;
        }// end function

        override public function get playerPersonId() : long
        {
            return UserObj.getInstance().playerInfo.personId;
        }// end function

        override public function get playerName() : String
        {
            return UserObj.getInstance().playerInfo.name;
        }// end function

        override public function get playerLevel() : int
        {
            return UserObj.getInstance().playerInfo.level;
        }// end function

    }
}
