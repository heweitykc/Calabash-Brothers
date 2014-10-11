package com.game.version.message
{
    import __AS3__.vec.*;
    import com.game.version.bean.*;
    import net.*;

    public class ResVersionUpdateToClientMessage extends Message
    {
        private var _versionlist:Vector.<VersionResInfo>;

        public function ResVersionUpdateToClientMessage()
        {
            this._versionlist = new Vector.<VersionResInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._versionlist.length);
            _loc_1 = 0;
            while (_loc_1 < this._versionlist.length)
            {
                
                writeBean(this._versionlist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._versionlist[_loc_1] = readBean(VersionResInfo) as VersionResInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 202101;
        }// end function

        public function get versionlist() : Vector.<VersionResInfo>
        {
            return this._versionlist;
        }// end function

        public function set versionlist(param1:Vector.<VersionResInfo>) : void
        {
            this._versionlist = param1;
            return;
        }// end function

    }
}
