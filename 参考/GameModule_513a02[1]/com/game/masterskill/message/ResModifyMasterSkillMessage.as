package com.game.masterskill.message
{
    import com.game.masterskill.bean.*;
    import net.*;

    public class ResModifyMasterSkillMessage extends Message
    {
        private var _treeType:int;
        private var _treePoint:int;
        private var _masterPoint:int;
        private var _info:MasterSkillInfo;

        public function ResModifyMasterSkillMessage()
        {
            return;
        }// end function

        public function set treeType(param1:int) : void
        {
            this._treeType = param1;
            return;
        }// end function

        public function get treeType() : int
        {
            return this._treeType;
        }// end function

        public function set treePoint(param1:int) : void
        {
            this._treePoint = param1;
            return;
        }// end function

        public function get treePoint() : int
        {
            return this._treePoint;
        }// end function

        public function set masterPoint(param1:int) : void
        {
            this._masterPoint = param1;
            return;
        }// end function

        public function get masterPoint() : int
        {
            return this._masterPoint;
        }// end function

        public function set info(param1:MasterSkillInfo) : void
        {
            this._info = param1;
            return;
        }// end function

        public function get info() : MasterSkillInfo
        {
            return this._info;
        }// end function

        override public function getId() : int
        {
            return 504102;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._treeType);
            writeInt(this._treePoint);
            writeInt(this._masterPoint);
            writeBean(this._info);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._treeType = readInt();
            this._treePoint = readInt();
            this._masterPoint = readInt();
            this._info = readBean(MasterSkillInfo) as MasterSkillInfo;
            return true;
        }// end function

    }
}
