
PROGRAM _CYCLIC
	

	CASE step OF
	    0:  (* start data recorder *)
			MpDataRecorder_0.Enable := 1;
			IF( MpDataRecorder_0.Active )THEN
				step := 10;
			END_IF

		10: (* create columns and register variables *)
			MpDataRegPar_0(	Enable := 1 );
			MpDataRegPar_1(	Enable := 1 );
			MpDataRegPar_2(	Enable := 1 );

			IF(    (MpDataRegPar_0.Active = FALSE AND MpDataRegPar_0.Error = FALSE) AND
					(MpDataRegPar_1.Active = FALSE AND MpDataRegPar_1.Error = FALSE) AND
					(MpDataRegPar_2.Active = FALSE AND MpDataRegPar_2.Error = FALSE) ) THEN
				step := 100;
			END_IF


		100:  (* wait for command *)
		IF( writeCSV = 1) THEN
			writeCSV := 2; (* busy *)
			MpDataRecorder_0.Record := TRUE;
			index := 0;
			step := 200;
		END_IF

		200: (* next record *)
		IF( MpDataRecorder_0.Error ) THEN
			step := 900;  (* Fehler *)
		ELSE
			MpDataRecorder_0( Trigger := FALSE );
			record := data[index];
			index := index + 1;
			MpDataRecorder_0.Trigger := TRUE;
			IF ( index > (MAX_ROWS-1) ) THEN
				MpDataRecorder_0.Record := FALSE;
				writeCSV := 0;
				step := 100; (* ready *)
			END_IF
		END_IF
		
	END_CASE

	MpDataRecorder_0();	


	 
END_PROGRAM
