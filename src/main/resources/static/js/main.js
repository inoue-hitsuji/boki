// キーボード操作を優先した入力支援

document.addEventListener('DOMContentLoaded', function() {
    // Enterキーで次のフィールドへ移動
    const inputs = document.querySelectorAll('input, select, textarea');
    inputs.forEach((input, index) => {
        input.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                const nextIndex = index + 1;
                if (nextIndex < inputs.length) {
                    inputs[nextIndex].focus();
                } else {
                    // 最後のフィールドなら送信ボタンをクリック
                    const submitBtn = document.querySelector('button[type="submit"]');
                    if (submitBtn) {
                        submitBtn.click();
                    }
                }
            }
        });
    });

    // 数値入力フィールドのフォーマット
    const amountInputs = document.querySelectorAll('input[type="number"][data-amount]');
    amountInputs.forEach(input => {
        input.addEventListener('blur', function() {
            if (this.value) {
                this.value = parseFloat(this.value).toFixed(2);
            }
        });
    });

    // 仕訳行の追加/削除（動的フォーム用）
    const addLineBtn = document.getElementById('add-line');
    const removeLineBtn = document.getElementById('remove-line');
    
    if (addLineBtn) {
        addLineBtn.addEventListener('click', function() {
            // 仕訳行を追加する処理（必要に応じて実装）
            console.log('Add line clicked');
        });
    }
});

// 金額のフォーマット表示
function formatAmount(amount) {
    if (!amount) return '0.00';
    return parseFloat(amount).toLocaleString('ja-JP', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    });
}

// 日付のフォーマット
function formatDate(dateString) {
    if (!dateString) return '';
    const date = new Date(dateString);
    return date.toLocaleDateString('ja-JP');
}


