package com.game.map.protocol
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.game.backpack.message.*;
    import com.game.login.message.*;
    import com.game.map.message.*;
    import com.game.structs.*;
    import com.game.task.message.*;
    import com.game.utils.*;
    import com.model.*;
    import interfaces.role.*;

    public class MapProtocol extends BaseProtocol
    {

        public function MapProtocol()
        {
            return;
        }// end function

        public function loadFinishForChangeMap() : void
        {
            var _loc_1:* = new ReqLoadFinishForChangeMapMessage();
            _loc_1.height = FrameworkGlobal.stageH;
            _loc_1.width = FrameworkGlobal.stageW;
            send(_loc_1);
            return;
        }// end function

        public function running(param1:int, param2:int, param3:Vector.<int>) : void
        {
            var _loc_4:* = new ReqRunningMessage();
            _loc_4.position = new Position();
            _loc_4.position.x = param1;
            _loc_4.position.y = param2;
            _loc_4.positions = param3;
            send(_loc_4);
            return;
        }// end function

        public function stopPath(param1:ISimpleRole) : void
        {
            var _loc_2:* = new ReqPlayerStopMessage();
            _loc_2.position = new Position();
            _loc_2.position.x = param1._x;
            _loc_2.position.y = param1._y;
            send(_loc_2);
            return;
        }// end function

        public function quitToGame() : void
        {
            var _loc_1:* = new ReqQuitMessage();
            send(_loc_1);
            return;
        }// end function

        public function changeMapByTransfer(param1:uint) : void
        {
            var _loc_2:* = new ReqChangeMapByMoveMessage();
            _loc_2.line = UserObj.getInstance().line;
            _loc_2.tranId = param1;
            send(_loc_2);
            return;
        }// end function

        public function takeupDropGood(param1:Vector.<long>) : void
        {
            var _loc_2:* = new ReqTakeUpMessage();
            _loc_2.goodsId = param1;
            send(_loc_2);
            return;
        }// end function

        public function changeMapByGold(param1:uint, param2:int = 0) : void
        {
            var _loc_3:* = new ReqGoldMapTransMessage();
            _loc_3.mapId = param1;
            _loc_3.line = param2;
            send(_loc_3);
            return;
        }// end function

        public function changeMapByPos(param1:uint, param2:int, param3:int, param4:long, param5:int, param6:int = 0) : void
        {
            var _loc_7:* = new ReqConqueryTaskTransMessage();
            _loc_7.mapid = param1;
            _loc_7.taskId = param4;
            _loc_7.x = param2;
            _loc_7.y = param3;
            _loc_7.line = param5;
            _loc_7.transtype = param6;
            send(_loc_7);
            return;
        }// end function

        public function reqLines() : void
        {
            var _loc_1:* = new ReqGetLinesMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqSelectLine(param1:int) : void
        {
            var _loc_2:* = new ReqSelectLineMessage();
            _loc_2.line = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
