; modified by RP on Feb. 26, 2001 
; added stuff for HRPoly in AMI 0.5 (PolyHRRes)

    (bkgnd = (geomBkgnd)) 

    (HR = (geomOr "HR")) ; added Feb. 26 2001 for AMI 0.5
    (CapWell = (geomOr "CapWell"))
    (SiBlock = (geomOr "SiBlock"))
    (Via2 = (geomOr "Via2"))
    (Metal3 = (geomOr "Metal3"))

    (Nwell = (geomOr "Nwell")) 
    (Pwell = (geomAndNot bkgnd Nwell))
    (Pselect = (geomOr "Pselect")) 
    (Nselect = (geomOr "Nselect")) 
    (Pbase = (geomOr "Pbase")) 
    (Active = (geomOr "Active")) 
    (Active1 = (geomOr Active Pbase))

    ;(ActX = (geomOr "ActX")) 
    (ActX = (geomAnd "ActX" "Active")) 
    (Poly1 = (geomOr "Poly1")) 
    ;(P1Con = (geomOr "P1Con"))
    (P1Con = (geomAnd "ActX" "Poly1")) 

    (Poly2 = (geomOr "Poly2")) 
    (P2Con = (geomOr "P2Con"))

    (P2Active = (geomAnd 
	    (geomNot Poly1) Active
	)) 
    (NotCCD = (geomAndNot Active 
	    (geomOr Poly1 Poly2)
	)) 
    (Metal1 = (geomOr "Metal1")) 
    (Metal2 = (geomOr "Metal2")) 
    (Via = (geomOr "Via"))
    (Glass = (geomOr "Glass")) 
    (XP = (geomOr "XP")) 
    (Resistor = (geomOr "Resistor")) 
    (Capacitor = (geomOr "Capacitor"))
    (Diode = (geomOr "Diode")) 
    (PolyCap = (geomAnd Poly1 Poly2)) 
    (NotTran = (geomOr Resistor (geomOr CapWell Capacitor))) 
    (NActive = (geomAnd Nselect Active)) 
    (PActive = (geomAnd Pselect Active))
    (NActive1 = (geomAndNot NActive Resistor)) 
    (NActive2 = (geomAndNot NActive1 Pbase)) 
    (PActive1 = (geomAndNot PActive Resistor)) 
    (Nwell1 = (geomAndNot Nwell Resistor)) 
    (NSD = (geomAndNot NActive2 
	    (geomAnd geomOr(Poly1 Poly2) Pwell)
	))
    (NSD1 = (geomAnd Nselect Pbase)) 
    (PSD = (geomAndNot PActive1 
	    (geomAnd geomOr(Poly1 Poly2) Nwell)
	))
    (ngate = (geomAndNot 
	    (geomAnd NActive Poly1) NotTran
	)) 
    (pgate = (geomAndNot 
	    (geomAnd PActive Poly1) NotTran
	))
    (ngate2 = (geomAnd (geomAndNot 
	    (geomAnd NActive Poly2) NotTran) geomNot(ngate)
	)) 
    (pgate2 = (geomAnd (geomAndNot 
	    (geomAnd PActive Poly2) NotTran) geomNot(pgate)
	)) 
    (gate = (geomOr ngate pgate ngate2 pgate2))

; DIODE
    (NDiode = (geomAnd Diode NActive1)) 
    (PDiode = (geomAnd Diode PActive1)) 

; FROM HP 0.5
    (Poly1wire = (geomAndNot Poly1 Resistor) )
 
; ADDED FEB. 26 2001 BY RP ***********
; HRPOLY RESISTOR (for AMI 0.5) 
    (Poly2wire = (geomAndNot Poly2 Resistor))

; NDIFF RESISTOR
    (NDiffRes_ = (geomAndNot 
            (geomAnd NActive Resistor) Nwell
        )) 
    (NTapNDRes = (geomAnd NDiffRes_ ActX))
    (NDiffRes = (geomAndNot NDiffRes_ NTapNDRes))

; PDIFF RESISTOR
    (PDiffRes_ = (geomAnd
            (geomAnd PActive Resistor) Nwell
        ))
    (PTapPDRes = (geomAnd PDiffRes_ ActX))
    (PDiffRes = (geomAndNot PDiffRes_ PTapPDRes))

; NWELL RESISTOR
    (NWellResistor_ = (geomAndNot
	(geomAnd Nwell Resistor) Pselect
    ))
    (NTapNWRes = (geomAnd NWellResistor_
	(geomAndNot NActive Poly1)
    ))
    (NWellResistor = (geomAndNot NWellResistor_ NTapNWRes))

; POLY RESISTOR (from HP 0.5)
    (PolySBResTap = (geomAnd Poly1wire
                    (geomSize (geomAnd Poly1 Resistor) 0.5 edges)))
    (PolySBRes = (geomOr PolySBResTap (geomAnd Poly1 Resistor)))
    (PolySBResVia = (geomOr PolySBResTap))

; ADDED FEB. 26 2001 BY RP
; HRPOLY RESISTOR (for AMI 0.5) 
    (PolyHRResTap = (geomAnd Poly2wire
    		    (geomSize (geomAnd Poly2 Resistor) 0.5 edges)))
    (PolyHRRes = (geomOr PolyHRResTap (geomAnd Poly2 Resistor)))
    (PolyHRResVia = (geomOr PolyHRResTap))

; WELL CONTACTS
    (NTap = (geomAnd Nwell 
	    (geomAndNot NActive2 Poly1)
	)) 
    (PTap = (geomAnd Pwell 
	    (geomAndNot PActive1 Poly1)
	))

; MOS CAPACITOR
    (NMoscap = (geomAnd 
	    (geomAnd Poly1wire NActive1) Capacitor
	)) 
    (PMoscap = (geomAnd 
	    (geomAnd Poly1wire PActive1) Capacitor
	)) 

; METAL1/POLY1 CAP (from HP 0.5)
    (M1P1cap = (geomAnd
            (geomAnd Poly1wire Metal1) Capacitor
        ))

; CAP WELL (HP 0.5)
    (CWellPlate = (geomAnd CapWell NActive1))
    (CWellCap = (geomAnd CWellPlate Poly1))
    (CWellTap = (geomAndNot CWellPlate Poly1))
    (Capgate = (geomAnd (geomAnd CapWell Poly1) Active ))

; BJT
    (NPN = (geomAnd Nselect Pbase)) 
    (base = (geomAndNot Pbase NSD1)) 

    (geomConnect 
	(via Via Metal1 Metal2) 
	(via Via2 Metal2 Metal3) ; HP 0.5
	(via P1Con Poly1wire Metal1) 
;	(via P1Con Poly1 Metal1) ; this is bad if we want to do poly res right
	(via P2Con Poly2wire Metal1)
        (via PolySBResVia Poly1wire PolySBResTap) ; HP 0.5
        (via PolyHRResVia Poly2wire PolyHRResTap) ; AMI 0.5 RP Feb. 26, 01 ***
	(via ActX NSD PSD CWellPlate Metal1)
	(via ActX NSD1 Metal1) 
	(via ActX base Metal1)
	(via ActX NTapNWRes NTapNDRes PTapPDRes Metal1)
        (via CWellTap CapWell CWellPlate)
	(via NTap Nwell1 NSD) 
	(via PTap Pwell PSD) 
	(label "text" Metal1 Metal2 Metal3 Poly1wire Poly2wire
	    Poly2 Resistor Capacitor
	)
    )
