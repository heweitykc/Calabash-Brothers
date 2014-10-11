package com.game.team.protocol
{
    import com.*;
    import com.game.team.message.*;
    import com.game.utils.*;

    public class TeamProtocol extends BaseProtocol
    {

        public function TeamProtocol()
        {
            return;
        }// end function

        public function reqApplyGame(param1:long) : void
        {
            var _loc_2:* = new ReqApplyGameMessage();
            _loc_2.teamid = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqApplyGameSelect(param1:long, param2:long, param3:Boolean) : void
        {
            var _loc_4:* = new ReqApplyGameSelectMessage();
            _loc_4.teamid = param1;
            _loc_4.playerid = param2;
            _loc_4.select = param3 == true ? (0) : (1);
            send(_loc_4);
            return;
        }// end function

        public function reqAppointGame(param1:long, param2:long) : void
        {
            var _loc_3:* = new ReqAppointGameMessage();
            _loc_3.teamid = param1;
            _loc_3.playerid = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqAutoIntoTeamApplyGame(param1:Boolean) : void
        {
            var _loc_2:* = new ReqAutoIntoTeamApplyGameMessage();
            _loc_2.autointoteamapply = param1 == true ? (1) : (0);
            send(_loc_2);
            return;
        }// end function

        public function reqAutoTeaminvitedGame(param1:Boolean) : void
        {
            var _loc_2:* = new ReqAutoTeaminvitedGameMessage();
            _loc_2.autoTeaminvited = param1 == true ? (1) : (0);
            send(_loc_2);
            return;
        }// end function

        public function reqCreateateamGame() : void
        {
            var _loc_1:* = new ReqCreateateamGameMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqGenericSearchToGame(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int) : void
        {
            var _loc_7:* = new ReqGenericSearchToGameMessage();
            _loc_7.type = param1;
            _loc_7.paneltype = param2;
            _loc_7.searchcontent = param3;
            _loc_7.indexstart = param4;
            _loc_7.indexend = param5;
            _loc_7.sort = param6;
            send(_loc_7);
            return;
        }// end function

        public function reqIntoTeamToGame(param1:long) : void
        {
            var _loc_2:* = new ReqIntoTeamToGameMessage();
            _loc_2.othersid = param1;
            return;
        }// end function

        public function reqInviteGame(param1:long, param2:long) : void
        {
            var _loc_3:* = new ReqInviteGameMessage();
            _loc_3.playerid = param1;
            _loc_3.teamid = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqInviteGameSelect(param1:long, param2:long, param3:Boolean) : void
        {
            var _loc_4:* = new ReqInviteGameSelectMessage();
            _loc_4.captainid = param2;
            _loc_4.select = param3 == true ? (0) : (1);
            _loc_4.teamid = param1;
            send(_loc_4);
            return;
        }// end function

        public function reqMapSearchMemberNameGame(param1:long) : void
        {
            var _loc_2:* = new ReqMapSearchMemberNameGameMessage();
            _loc_2.teamid = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqMapSearchPlayerInfoGame(param1:String) : void
        {
            var _loc_2:* = new ReqMapSearchPlayerInfoGameMessage();
            _loc_2.searchcontent = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqMapSearchTeamInfoGame() : void
        {
            var _loc_1:* = new ReqMapSearchTeamInfoGameMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqToLeaveGame(param1:long, param2:int) : void
        {
            var _loc_3:* = new ReqToleaveGameMessage();
            _loc_3.playerid = param1;
            _loc_3.type = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqUpdateTeamInfoGame(param1:long) : void
        {
            var _loc_2:* = new ReqUpdateTeaminfoGameMessage();
            _loc_2.teamid = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
