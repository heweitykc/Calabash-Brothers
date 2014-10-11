package com.model
{
    import com.events.*;
    import com.f1.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class MagicBookRoleList extends Object
    {
        private var _playerMagicBook:IMagicBookRole;
        private var _magicBooks:Dictionary;
        private static var instance:MagicBookRoleList;

        public function MagicBookRoleList()
        {
            return;
        }// end function

        public function reset() : void
        {
            this._magicBooks = new Dictionary();
            return;
        }// end function

        public function addMagicBookRole(param1:IMagicBookRole) : void
        {
            if (param1)
            {
                this._magicBooks[MagicBookInfo(param1.info).parentId.toString()] = param1;
            }
            return;
        }// end function

        public function removeMagicBookRole(param1:IMagicBookRole) : void
        {
            if (!param1)
            {
                return;
            }
            if (param1 == this._playerMagicBook)
            {
                this._playerMagicBook = null;
            }
            if (param1.info)
            {
                this._magicBooks[MagicBookInfo(param1.info).parentId.toString()] = null;
            }
            delete this._magicBooks[MagicBookInfo(param1.info).parentId.toString()];
            return;
        }// end function

        public function getMagicBookRole(param1:long) : IMagicBookRole
        {
            if (!param1)
            {
                return null;
            }
            return this._magicBooks[param1.toString()];
        }// end function

        public function get playerMagicBook() : IMagicBookRole
        {
            return this._playerMagicBook;
        }// end function

        public function set playerMagicBook(param1:IMagicBookRole) : void
        {
            this._playerMagicBook = param1;
            FrameworkGlobal.sendMsg(new GameEvent(GameEvent.PLAYER_CUTE_PET_STATE_UPDATE));
            return;
        }// end function

        public static function getInstance() : MagicBookRoleList
        {
            if (instance == null)
            {
                instance = new MagicBookRoleList;
            }
            return instance;
        }// end function

    }
}
