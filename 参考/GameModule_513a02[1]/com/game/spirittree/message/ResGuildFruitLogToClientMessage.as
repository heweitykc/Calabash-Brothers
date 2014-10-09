package com.game.spirittree.message
{
    import __AS3__.vec.*;
    import com.game.spirittree.bean.*;
    import net.*;

    public class ResGuildFruitLogToClientMessage extends Message
    {
        private var _guildfruitlog:Vector.<GuildFruitLog>;

        public function ResGuildFruitLogToClientMessage()
        {
            this._guildfruitlog = new Vector.<GuildFruitLog>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._guildfruitlog.length);
            _loc_1 = 0;
            while (_loc_1 < this._guildfruitlog.length)
            {
                
                writeBean(this._guildfruitlog[_loc_1]);
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
                
                this._guildfruitlog[_loc_1] = readBean(GuildFruitLog) as GuildFruitLog;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 133107;
        }// end function

        public function get guildfruitlog() : Vector.<GuildFruitLog>
        {
            return this._guildfruitlog;
        }// end function

        public function set guildfruitlog(param1:Vector.<GuildFruitLog>) : void
        {
            this._guildfruitlog = param1;
            return;
        }// end function

    }
}
