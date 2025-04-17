---
layout: none
title: ""
---

**User Story: Integrate Image and PDF OCR Functionality**

**As a** VoxLogAI user,
**I want** to be able to select a processing mode (either "Audio/Video Transcription" or "Document OCR") and then choose the specific input method relevant to that mode (Upload File, YouTube URL, Image Upload, PDF Upload),
**So that** I can easily extract text from audio recordings, YouTube videos, images, and PDF documents using a single, unified interface.

**Acceptance Criteria:**

**1. Mode Selection UI:**
    *   A mode selection mechanism (e.g., visually distinct radio buttons or a segmented control) is present above the input tabs.
    *   The modes are clearly labeled, for example: "Audio/Video Transcription" and "Document OCR".
    *   One mode is selected by default (recommend "Audio/Video Transcription").
    *   Selecting a mode visually indicates it's active.

**2. Conditional Tab Display:**
    *   When "Audio/Video Transcription" mode is selected, the tabs displayed are "Upload Audio" and "YouTube URL". The content/functionality of these tabs remains as currently implemented.
    *   When "Document OCR" mode is selected, the tabs displayed are "Upload Image" and "Upload PDF". The "Upload Audio" and "YouTube URL" tabs are hidden.
    *   Switching modes correctly updates the visible set of tabs.

**3. Image Upload Tab:**
    *   When the "Upload Image" tab is active (under "Document OCR" mode):
        *   An upload zone is displayed, specifically prompting for image files.
        *   The zone uses an appropriate icon (e.g., `fa-file-image`).
        *   The file input accepts common image formats (`image/jpeg`, `image/png`, `image/webp`, `image/heic`, `image/heif`).
        *   A reasonable file size limit (20MB) is enforced, with clear error messages if exceeded.
        *   Selecting a valid image file updates the UI to show the filename and enables the main action button.

**4. PDF Upload Tab:**
    *   When the "Upload PDF" tab is active (under "Document OCR" mode):
        *   An upload zone is displayed, specifically prompting for PDF files.
        *   The zone uses an appropriate icon (e.g., `fa-file-pdf`).
        *   The file input accepts the PDF format (`application/pdf`).
        *   A reasonable file size limit (20MB) is enforced, with clear error messages if exceeded.
        *   Selecting a valid PDF file updates the UI to show the filename and enables the main action button.

**5. Conditional Options:**
    *   The "Include timestamps" checkbox/toggle is *only* visible when the "Audio/Video Transcription" mode is active.
    *   The "Include timestamps" option is hidden when the "Document OCR" mode is active.

**6. Contextual Action Button:**
    *   The main action button's text changes based on the active mode:
        *   "Audio/Video Transcription" mode: Button text is "Transcribe".
        *   "Document OCR" mode: Button text is "Extract Text" or "Perform OCR".
    *   The button's enabled/disabled state correctly reflects whether valid input (file selected or valid URL entered) exists for the *currently active tab within the selected mode*.

**7. Unified Result Display:**
    *   The header for the result area is renamed from "Transcript" to something more general like "Result" or "Extracted Text".
    *   Text extracted from images or PDFs via the Gemini API is displayed in this result area.
    *   The "Copy to clipboard" and "Start new transcription" (perhaps rename to "Start New") buttons function correctly for the OCR results.

**8. Backend Implementation:**
    *   New Flask endpoints (e.g., `/ocr_image`, `/ocr_pdf`) are created.
    *   These endpoints accept POST requests containing the image or PDF file data.
    *   Backend logic uses the Gemini API to perform OCR on the received image (e.g., using PIL) or PDF (e.g., using `types.Part.from_bytes`). Please look at `random_tests/gemini_image_ocr.py` and `random_tests/gemini_pdf_ocr.py` to check for working examples.
    *   The backend handles potential errors during file processing or API interaction and returns informative JSON error messages to the frontend.
    *   File size limits are enforced on the backend as well.
    *   Temporary file handling for OCR is minimal (ideally process in memory or delete immediately after API call), avoiding the `file_id` mapping used for audio.

**9. State Management & Usability:**
    *   Switching between modes ("Audio/Video" <-> "Document OCR") clears any selected file or entered URL from the *previously* active mode's tabs and resets the result area/status messages.
    *   The UI remains responsive and usable on both desktop and mobile screen sizes. The mode switcher + 2 tabs should fit comfortably on mobile.

**10. Dependencies:**
    *   Ensure necessary libraries (like `Pillow` for image handling if needed server-side, though Gemini might handle it directly) are added to `requirements.txt`.

**11. Delete data:**
    *   Ensure that no data (image/pdf/audio/etc) stays in the server after operation is done. We do NOT want to keep any user data.
