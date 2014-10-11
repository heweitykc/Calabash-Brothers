package com.game.artifact.protocol
{
    import __AS3__.vec.*;
    import com.*;
    import com.game.artifact.message.*;

    public class ArtifactProtocol extends BaseProtocol
    {

        public function ArtifactProtocol()
        {
            return;
        }// end function

        public function reqOpenArtifact() : void
        {
            var _loc_1:* = new ReqOpenArtifactMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqExtractArtifact(param1:Vector.<long>, param2:Boolean, param3:Boolean) : void
        {
            var _loc_4:* = new ReqExtractArtifactMessage();
            _loc_4.itemIds = param1;
            _loc_4.useGold = param2 ? (1) : (0);
            _loc_4.isDoubleExp = param3 ? (1) : (0);
            send(_loc_4);
            return;
        }// end function

        public function reqRemoldArtifact(param1:Vector.<long>) : void
        {
            var _loc_2:* = new ReqRemoldArtifactMessage();
            _loc_2.itemIds = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqSaveArtifactSetting(param1:String) : void
        {
            var _loc_2:* = new ReqSaveArtifactSettingMessage();
            _loc_2.saveSetting = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
