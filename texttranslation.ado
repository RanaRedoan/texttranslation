*! version 1.0.0 10aug2025
program define texttranslation, rclass
    version 17
    syntax using/, ORIGINALvar(name) OUTPUT(string)

    // Check input file exists
    confirm file `"`using'"'

    // Import Excel file
    di as txt "Reading Excel file: `using'"
    import excel `"`using'"', firstrow clear

    // Check that the specified variable exists
    confirm variable `originalvar'

    // Create copy of original variable
    gen strL _original_text = `originalvar'

    // Save just the text to a temporary CSV
    tempfile tempcsv
    export delimited _original_text using `tempcsv', replace novarnames

    // Path to helper script (in same directory as ado file)
    local pyhelper = "`c(pwd)'\translate_helper.py"
    if (fileexists("translate_helper.py")==0) {
        di as error "Helper file translate_helper.py not found in current directory."
        di as error "Make sure translate_helper.py is in the same folder as texttranslation.ado"
        error 601
    }

    di as txt "Translating text using Google Translate free service..."
    shell python "`pyhelper'" "`tempcsv'" > translated_output.txt

    // Import translations
    import delimited translated_output.txt, clear
    rename v1 _translated_text

    // Merge translations with original data
    merge 1:1 _n using `"`using'"', nogen

    // Save output Excel
    export excel using `"`output'"', firstrow(variables) replace

    di as txt "✅ Translation complete. Output saved to: `output'"
end
