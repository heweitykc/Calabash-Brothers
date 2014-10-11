package com.game.redfortress.message
{
    import __AS3__.vec.*;
    import com.game.redfortress.bean.*;
    import net.*;

    public class ResCsysTopListMessage extends Message
    {
        private var _infos:Vector.<CsysTopInfo>;

        public function ResCsysTopListMessage()
        {
            this._infos = new Vector.<CsysTopInfo>;
            return;
        }// end function

        public function set infos(param1:Vector.<CsysTopInfo>) : void
        {
            this._infos = param1;
            return;
        }// end function

        public function get infos() : Vector.<CsysTopInfo>
        {
            return this._infos;
        }// end function

        override public function getId() : int
        {
            return 550101;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._infos.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._infos.length)
            {
                
                writeBean(this._infos[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._infos[_loc_2] = readBean(CsysTopInfo) as CsysTopInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
