

PROGRAM _INIT

	(* simulation data *)
	FOR i:= 0 TO (MAX_ROWS-1) DO
		data[i].count := INT_TO_USINT(i+1);
		brsitoa( i+1, ADR(s1) );
		s2 := 'parameter ';
		s2 := CONCAT( s2, s1 );
		data[i].parameter := s2;
		data[i].value := 3.14 * i;
	END_FOR

	MpDataRecorder_0(	MpLink := ADR(gDataRecorder) , 
						Enable := 0,
						DeviceName := ADR('hdd'), 
						RecordMode := mpDATA_RECORD_MODE_TRIGGER  );	

	MpDataRegPar_0(		MpLink := ADR(gDataRecorder), 
						Enable := 0, 
						PVName := ADR('prog1:record.count'), 
						Unit := ADR('St'), 
						Description := ADR('count'), 
						ScaleFactor := 1);

	MpDataRegPar_1(		MpLink := ADR(gDataRecorder), 
						Enable := 0, 
						PVName := ADR('prog1:record.parameter'), 
						Unit := ADR('parameter'), 
						Description := 0, 
						ScaleFactor := 1);

	MpDataRegPar_2(		MpLink := ADR(gDataRecorder), 
						Enable := 0, 
						PVName := ADR('prog1:record.value'), 
						Unit := ADR('value'), 
						Description := 0, 
						ScaleFactor := 1);


	step := 0;
	
END_PROGRAM